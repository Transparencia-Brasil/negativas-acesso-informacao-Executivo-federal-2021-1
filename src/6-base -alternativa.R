library(glue)
library(tidyverse)
library(here)

#' ano ref
anos <- 2012:2022

#' url-mãe onde estão os arquivos
url_mae <- "https://dadosabertos-download.cgu.gov.br/FalaBR/Arquivos_FalaBR"

#' lista de urls diretos para download arquivos de **pedidos**
urls_pedidos <- glue("{url_mae}/Pedidos_csv_{anos}.zip")

#' lista de urls diretos para download arquivos de **recursos**
urls_recursos <- glue("{url_mae}/Recursos_Reclamacoes_csv_{anos}.zip")

#' lista de caminhos relativos para armazenar os downloads de **pedidos**
destfiles_pedidos <- glue(here("dados/load/reduzido/Pedidos_csv_{anos}.zip"))

#' lista de caminhos relativos para armazenar os downloads de **pedidos**
destfiles_recursos <- glue(here("dados/load/reduzido/Recursos_csv_{anos}.zip"))

#' lista combinada de urls de **pedidos** e **recursos**
urls <- cbind(urls_pedidos, urls_recursos)

#' lista combinada de caminhos relativos para armazenar os downloads de **pedidos** e **recursos**
destfiles <- cbind(destfiles_pedidos, destfiles_recursos)

#' diretório que guardará os arquivos extraídos
exdir <- here("dados/load/reduzido")
dir.create(exdir)

#' download !
walk2(urls, destfiles, download.file, mode = "wb")

#' unzip ! terminando o processo o caminho dos arquivos ficam armazenados no objeto como `string`
csv_files <- map(destfiles, unzip, exdir = exdir)

#' extract data !
read_lai <- function(arquivo) {
  
  message(glue::glue("get {arquivo}"))
  
  if (stringr::str_detect(arquivo, "Pedidos")) {
    colunas <- c(
      "id_pedido",
      "protocolo",
      "esfera",
      "orgao",
      "situacao",
      "data_registro",
      "resumo",
      "detalhamento",
      "prazo",
      "foi_prorrogado",
      "foi_reencaminhado",
      "forma_resposta",
      "origem_da_solicitaca",
      "id_solicitante",
      "assunto",
      "sub_assunto",
      "tag",
      "data_resposta",
      "resposta",
      "decisao",
      "especificacao_decisao"
    )
  } else if (stringr::str_detect(arquivo, "Recursos")) {
    colunas <- c(
      "id_recurso",
      "id_recurso_precedente",
      "desc_recurso",
      "id_pedido",
      "id_solicitante",
      "protocolo_pedido",
      "orgao_destinatario",
      "instancia",
      "situacao",
      "data_registro",
      "prazo_atendimento",
      "origem_solicitacao",
      "tipo_recurso",
      "data_resposta",
      "resposta_recurso",
      "tipo_resposta"
    )
  } else if (stringr::str_detect(arquivo, "Solicitantes")) {
    stop(glue::glue("{arquivo} is too big!"))
  } else {
    stop(glue::glue("{arquivo} is not a LAI file!"))
  }
  
  df <- readr::read_csv2(
    file = arquivo,
    col_names = colunas,
    col_types = readr::cols(.default = readr::col_character()),
    quote = '\'',
    locale = readr::locale(encoding = "UTF-16LE")
  )
  
  return(df)
  
}

#' Base de dados simplificada da CGU:
#' * pedidos              
#' * solicitantes_pedidos 
#' * recursos_reclamacoes 
#' * solicitantes_recursos
base_cgu <- csv_files %>% 
  enframe(name = "id", value = "path") %>% 
  unnest(path) %>% 
  mutate(
    base = str_extract(path, "(?<=\\d{8}_).+(?=_csv_\\d{4}\\.csv$)"), 
    base = snakecase::to_snake_case(base),
    ano = str_extract(path, "\\d{4}(?=\\.csv$)"),
    tabela = map(path, read_lai)
  )

#' salva todas as bases em um único arquivo
saveRDS(base_cgu, here("dados/load/rds/base_cgu.rds"))

#' deleta arquivos zip e xml
"dados/load/reduzido" %>%
  here() %>%
  unlink(recursive = TRUE)

#' teste
readRDS(here("dados/load/rds/base_cgu.rds")) %>% 
  filter(base == "pedidos") %>% 
  unnest(tabela) %>% 
  glimpse()
