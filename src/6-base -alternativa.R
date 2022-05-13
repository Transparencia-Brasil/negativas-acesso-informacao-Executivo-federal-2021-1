library(glue)
library(tidyverse)
library(here)

#' cria uma pasta para gerenciar arquivos baixados
exdir <- here("dados/load/temp")
unlink(exdir, recursive = TRUE)
dir.create(exdir)

#' url e destino dos arquivos
url_base <- "https://dadosabertos-download.cgu.gov.br/FalaBR/Arquivos_FalaBR/{interacao}_csv_{ano}.zip"
destfile_base <- "{exdir}/{interacao}_csv_{ano}.zip"

files_cgu <- tibble(ano = 2012:2022) %>%
  expand(ano, interacao = c("Pedidos", "Recursos_Reclamacoes")) %>% 
  mutate(
    url = glue(url_base),
    destfile = glue(destfile_base)
  )

#' download !
download.file_safe <- safely(download.file)
walk2(files_cgu$url, files_cgu$destfile, download.file_safe, mode = "wb")

#' unzip ! terminando o processo o caminho dos arquivos ficam armazenados no objeto como `string`
unzip_safe <- safely(unzip)
walk(files_cgu$destfile, unzip_safe, exdir = exdir)

#' extract data !
read_lai <- function(arquivo) {
  
  message(glue::glue("get {arquivo}"))
  
  if (stringr::str_detect(arquivo, "Pedidos")) {
    colunas <- c(
      "id_pedido",
      "protocolo",
      "esfera",
      "uf",
      "municipio",
      "orgao",
      "situacao",
      "data_registro",
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
      "decisao",
      "especificacao_decisao"
    )
  } else if (stringr::str_detect(arquivo, "Recursos")) {
    colunas <- c(
      "id_recurso",
      "id_recurso_precedente",
      "id_pedido",
      "id_solicitante",
      "protocolo_pedido",
      "esfera",
      "uf",
      "municipio",
      "orgao",
      "instancia",
      "situacao",
      "data_registro",
      "prazo_atendimento",
      "origem_solicitacao",
      "tipo_recurso",
      "data_resposta",
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
files_cgu <- list.files(path = here("dados/load/temp"), pattern = "csv$",full.names = TRUE) %>% 
  as_tibble_col(column_name = "csv") %>% 
  mutate(ano = as.integer(str_extract(csv, "\\d+(?=\\.csv)")),
         interacao = str_extract(csv, "(?<=_)Pedidos|Recursos_Reclamacoes")) %>% 
  na.omit() %>% 
  left_join(files_cgu, .) %>% 
  mutate(tabela = map(csv, read_lai))

#' salva todas as bases em um único arquivo
saveRDS(files_cgu, here("dados/load/rds/base-cgu.rds"))

#' teste
readRDS(here("dados/load/rds/base-cgu.rds")) %>% 
  filter(interacao == "Pedidos") %>% 
  unnest(tabela) %>% 
  sample_n(1) %>% 
  glimpse()

readRDS(here("dados/load/rds/base_cgu.rds")) %>% 
  filter(interacao == "Recursos_Reclamacoes") %>% 
  unnest(tabela) %>% 
  sample_n(1) %>% 
  glimpse()

#' deleta arquivos zip e xml
"dados/load/temp" %>%
  here() %>%
  unlink(recursive = TRUE)
