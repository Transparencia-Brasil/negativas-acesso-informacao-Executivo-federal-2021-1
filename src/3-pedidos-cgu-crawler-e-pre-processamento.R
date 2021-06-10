library(here)
library(glue)
library(tidyverse)

anos <- 2015:2021
path_files_zip <- here(glue("dados/raw/Arquivos_xml_{anos}.zip"))

dir.create(here("dados/load"))
dir.create(here("dados/load/xml"))
dir.create(here("dados/load/rds"))

# extract zip files
walk(path_files_zip,  ~ unzip(.x, exdir = , here("dados/load/xml")))

# exclui bases que não serão trabalhadas
list.files(here("dados/load/xml"), pattern = "Solicitantes", full.names = T) %>% 
  walk(unlink)

# função que abre e faxina nos arquivos XML baixados
extract_data_from_xml <- function(path) {
  
  path %>%                                      # recebe o caminho do arquivo xml
    file(encoding = "utf-16") %>%               # abre o arquivo
    readLines() %>%                             # lê o arquivo como texto
    xml2::read_html(encoding = "utf-16") %>%    # lê o texto como xml
    xml2::as_list() %>%                         # converte atributos do xml em obj list
    .[[1]] %>%                                  # acessa conteúdos do list object pra devolver uma tabela estruturada
    .[[1]] %>%                                  # .
    .[[1]] %>%                                  # .
    purrr::map(`[`) %>%                         # .
    purrr::map(attributes) %>%                  # .
    purrr::map(as_tibble) %>%                   # acessamos os conteúdos e agora cada linha virou uma tibble
    dplyr::bind_rows()                          # empilha essas linhas e temos a tabela final ! horaayyy =D
  
}

# seleciona xml files:
path_files_xml_pedidos <- list.files(here("dados/load/xml"), pattern = "Pedidos", full.names = T)
path_files_xml_recursos <- list.files(here("dados/load/xml"), pattern = "Recursos", full.names = T)

dados_cgu_nested <- function(df) {
  
  df %>% 
    purrr::map(extract_data_from_xml) %>% 
    purrr::set_names(as.character(2015:2021)) %>% 
    tibble::enframe(name = "ano") %>% 
    tidyr::unnest(value)
  
}

# atenção: o loop para todos os datasets demora um bocado (+-1h)
pedidos_cgu <- dados_cgu_nested(path_files_xml_pedidos)
recursos_cgu <- dados_cgu_nested(path_files_xml_recursos)

glimpse(pedidos_cgu)
glimpse(recursos_cgu)

saveRDS(pedidos_cgu, here("dados/load/rds/pedidos-cgu.rds"))
saveRDS(recursos_cgu, here("dados/load/rds/recursos-cgu.rds"))

pedidos_cgu %>% group_by(ano) %>% nest() %>% saveRDS(here("dados/load/rds/pedidos-cgu.rds"))
recursos_cgu %>% group_by(ano) %>% nest() %>% saveRDS(here("dados/load/rds/recursos-cgu.rds"))
