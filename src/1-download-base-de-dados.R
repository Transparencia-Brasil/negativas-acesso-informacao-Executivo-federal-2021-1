`%>%` <- magrittr::`%>%`

#' params
years <- 2015:2022
urls <- "https://dadosabertos-download.cgu.gov.br/FalaBR/Arquivos_FalaBR_Filtrado/Arquivos_csv_{years}.zip"
zip_files <- "dados/Arquivos_csv_{years}.zip"
data_ref <- stringr::str_remove_all(Sys.Date(), "-")
exdir <- "dados"

dwld <- tibble::tibble(urls = glue::glue(urls),
                       years = years,
                       zip_files = here::here(glue::glue(zip_files)),
                       exdir = here::here(exdir)
)

#' download
purrr::walk2(dwld$urls, dwld$zip_files, ~ download.file(url = .x, destfile = .y, mode = "wb"))

#' unzip
purrr::walk2(dwld$zip_files, dwld$exdir, ~ unzip(zipfile = .x, exdir = .y))

# read files
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
  
  readr::read_csv2(
    file = arquivo,
    col_names = colunas,
    col_types = readr::cols(.default = readr::col_character()),
    quote = '\'',
    locale = readr::locale(encoding = "UTF-16LE")
  )
  
}

#' local file path
getfiles_lai <- function(base) {
  list.files(here::here("dados"), pattern = base, full.names = T)
}

#' pedidos dataset
"Pedidos" %>% 
  getfiles_lai() %>% 
  purrr::map_df(read_lai) %>% 
  readr::write_csv(here::here("dados/pedidos.csv"))

#' recursos dataset
"Recursos" %>% 
  getfiles_lai() %>% 
  purrr::map_df(read_lai) %>% 
  readr::write_csv(here::here("dados/recursos.csv"))

#' remove extra datasets
"dados" %>% 
  here::here() %>% 
  list.files(pattern = "_csv_|zip$", full.names = TRUE) %>%
  purrr::walk(unlink)
