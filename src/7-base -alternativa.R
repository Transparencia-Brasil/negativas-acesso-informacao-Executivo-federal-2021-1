library(glue)
library(tidyverse)
library(here)

#' url-mãe onde estão os arquivos
url_mae <- "https://dadosabertos-download.cgu.gov.br/FalaBR/Arquivos_FalaBR"

#' lista de urls diretos para download arquivos de **pedidos**
urls_pedidos <- glue("{url_mae}/Pedidos_xml_{2012:2021}.zip")

#' lista de urls diretos para download arquivos de **recursos**
urls_recursos <- glue("{url_mae}/Recursos_Reclamacoes_xml_{2012:2021}.zip")

#' lista de caminhos relativos para armazenar os downloads de **pedidos**
destfiles_pedidos <- glue(here("dados/load/xml/reduzido/Pedidos_xml_{2012:2021}.zip"))

#' lista de caminhos relativos para armazenar os downloads de **pedidos**
destfiles_recursos <- glue(here("dados/load/xml/reduzido/Recursos_xml_{2012:2021}.zip"))

#' lista combinada de urls de **pedidos** e **recursos**
urls <- cbind(urls_pedidos, urls_recursos)

#' lista combinada de caminhos relativos para armazenar os downloads de **pedidos** e **recursos**
destfiles <- cbind(destfiles_pedidos, destfiles_recursos)

#' download !
walk2(urls, destfiles, download.file, mode = "wb")

#' diretório que guardará os arquivos extraídos
exdir <- here("dados/load/xml/reduzido")

#' unzip ! terminando o processo o caminho dos arquivos ficam armazenados no objeto como `string`
xml_files <- map(destfiles, unzip, exdir = exdir)

#' função que abre os arquivos `XML` baixados e faz o parse para uma `tibble`
extract_data_from_xml <- function(path) {
  
  path %>%
    file(open = "r", encoding = "UTF-16LE") %>%
    readLines(encoding = "UTF-16LE") %>%   
    str_replace_all("&", "") %>% 
    xml2::read_xml(encoding = "UTF-16LE") %>%
    xml2::as_list() %>%
    purrr::pluck(1) %>%
    purrr::map_df(attributes)
  
}

#' lista com ids de caminhos relativos dos arquivos xml extraídos, armazena também uma `tibble` com os dados parseados
xml_files <- xml_files %>% 
  enframe(name = "id", value = "path") %>% 
  unnest(path) %>% 
  mutate(
    base = str_extract(path, "(?<=\\d{8}_).+(?=_xml_\\d{4}\\.xml$)"), 
    base = snakecase::to_snake_case(base),
    ano = str_extract(path, "\\d{4}(?=\\.xml$)"),
    tabela = map(path, extract_data_from_xml)
  )

#' Base de dados simplificada da CGU:
#' * pedidos              
#' * solicitantes_pedidos 
#' * recursos_reclamacoes 
#' * solicitantes_recursos
base_cgu <- xml_files %>%
  group_by(base) %>% 
  nest() %>%
  deframe() %>% 
  map(unnest, tabela)

#' salva todas as bases em um único arquivo
saveRDS(base_cgu, here("dados/load/rds/base_cgu.rds"))

#' deleta arquivos zip e xml
"dados/load/xml/reduzido" %>%
  here() %>%
  list.files(pattern = "\\.(xml|zip)$", full.names = TRUE) %>%
  walk(unlink)

#' teste
readRDS(here("dados/load/rds/base_cgu.rds")) %>% 
  pluck("pedidos")
