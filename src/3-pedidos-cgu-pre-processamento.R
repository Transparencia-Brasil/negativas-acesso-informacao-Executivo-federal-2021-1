library(here)
library(glue)
library(tidyverse)
library(lubridate)

#' lista de anos disponíveis
anos <- 2015:2021

#' string com caminhos relativos dos arquivos zip
path_files_zip <- here(glue("dados/raw/Arquivos_xml_{anos}.zip"))

# dir.create(here("dados/load"))
# dir.create(here("dados/load/xml"))
# dir.create(here("dados/load/rds"))
# dir.create(here("dados/load/csv"))

#' extract zip files
walk(path_files_zip,  unzip, exdir = here("dados/load/xml"))

#' exclui bases que não serão trabalhadas
list.files(here("dados/load/xml"), pattern = "Solicitantes|^202109", full.names = T) %>% 
  walk(unlink)

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

#' lista de arquivos do tipo *pedidos*
path_files_xml_pedidos <- tibble(file = list.files(here("dados/load/xml"), pattern = "Pedidos", full.names = T),
                                 id = str_extract(file, "_\\d{4}"))

#' lista de arquivos do tipo *recursos*
path_files_xml_recursos <- tibble(file = list.files(here("dados/load/xml"), pattern = "Recursos", full.names = T),
                                  id = str_extract(file, "_\\d{4}"))

#' lista de arquivos do tipo *solicitantes*
path_files_xml_solicitantes <- tibble(file = list.files(here("dados/load/xml"), pattern = "Solicitantes", full.names = T),
                                  id = str_extract(file, "_\\d{4}"))

#' função que controla o parse dos arquivos XML e aninha os daados em uma 
#' tabela única
dados_cgu_nested <- function(xml_path, xml_id) {
  
  xml_path %>% 
    purrr::map(extract_data_from_xml) %>% 
    purrr::set_names(xml_id) %>% 
    tibble::enframe(name = "id_ano_base") %>% 
    tidyr::unnest(value)
  
}

#' Base de dados de pedidos 
pedidos_cgu <- dados_cgu_nested(path_files_xml_pedidos$file, path_files_xml_pedidos$id)
#' atenção: o loop para todos os datasets demora um bocado (+-1h)

#' base de dados de recursos
recursos_cgu <- dados_cgu_nested(path_files_xml_recursos$file, path_files_xml_recursos$id)

#' Base de dados de pedidos pronta para uso
pedidos_cgu <- pedidos_cgu %>% 
  janitor::clean_names() %>% 
  mutate(
    ts_registro = data_registro,
    ts_resposta = data_resposta,
    data_registro = dmy(data_registro) %>% floor_date(unit = "month"),
    data_resposta = dmy(data_resposta) %>% floor_date(unit = "month"),
    governo_que_respondeu = case_when(
      data_resposta < as_date("2016-05-12") ~ "Dilma II",
      data_resposta < as_date("2019-01-01") ~ "Temer",
      TRUE ~ "Bolsonaro"
    ),
    governo_que_registrou = case_when(
      data_registro < as_date("2016-05-12") ~ "Dilma II",
      data_registro < as_date("2019-01-01") ~ "Temer",
      TRUE ~ "Bolsonaro"
    ),
    governo_que_respondeu = factor(governo_que_respondeu, levels = c("Dilma II", "Temer", "Bolsonaro")),
    governo_que_registrou = factor(governo_que_registrou, levels = c("Dilma II", "Temer", "Bolsonaro"))
  )

#' Base de dados de recursos pronta para uso
recursos_cgu <- recursos_cgu %>%
  janitor::clean_names() %>% 
  mutate(
    ts_registro = data_registro,
    ts_resposta = data_resposta,
    data_registro = dmy(data_registro) %>% floor_date(unit = "month"),
    data_resposta = dmy(data_resposta) %>% floor_date(unit = "month"),
    governo_que_respondeu = case_when(
      data_resposta < as_date("2016-05-12") ~ "Dilma II",
      data_resposta < as_date("2019-01-01") ~ "Temer",
      TRUE ~ "Bolsonaro"
    ),
    governo_que_registrou = case_when(
      data_registro < as_date("2016-05-12") ~ "Dilma II",
      data_registro < as_date("2019-01-01") ~ "Temer",
      TRUE ~ "Bolsonaro"
    ),
    governo_que_respondeu = factor(governo_que_respondeu, levels = c("Dilma II", "Temer", "Bolsonaro")),
    governo_que_registrou = factor(governo_que_registrou, levels = c("Dilma II", "Temer", "Bolsonaro"))
  )

#' salva em rds
saveRDS(pedidos_cgu, here("dados/load/rds/pedidos-cgu.rds"))
saveRDS(recursos_cgu, here("dados/load/rds/recursos-cgu.rds"))

#' salva em csv
write_csv(pedidos_cgu, file = here("dados/load/csv/pedidos-cgu.csv"))
write_csv(recursos_cgu, file = here("dados/load/csv/recursos-cgu.csv"))

#' teste do arquivo csv
test <- read_csv(here("dados/load/csv/pedidos-cgu.csv"))
glimpse(test)

