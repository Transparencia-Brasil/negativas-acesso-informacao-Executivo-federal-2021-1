library(here)
library(glue)
library(tidyverse)
library(lubridate)

anos <- 2021
path_files_xml <- "dados/load/xml" %>%
  here() %>%
  list.files(pattern = "Solicitantes", full.names = TRUE)

path_files_xml_solicitantes <- tibble(
  file = path_files_xml,
  id = str_extract(file, "_\\d{4}")
)

# função que abre e faxina nos arquivos XML baixados
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

# atenção: o loop para todos os datasets demora um bocado (+-1h)
solicitantes_cgu <- dados_cgu_nested(path_files_xml_solicitantes$file, path_files_xml_recursos$id)

saveRDS(solicitantes_cgu, here("dados/load/rds/solicitantes-cgu.rds"))

write.csv2(as.data.frame(solicitantes_cgu),
           file = here("dados/load/csv/solicitantes-cgu.csv"),
           row.names = F,
           na = "",
           fileEncoding = "UTF-8")

test <- read_delim(here("dados/load/csv/solicitantes-cgu.csv"), ";", col_types = cols())
glimpse(test)