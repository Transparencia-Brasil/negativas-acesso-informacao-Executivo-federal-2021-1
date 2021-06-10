library(here)
library(glue)
library(tidyverse)
dir.create(here("dados/raw"))

# carrega a função `download_cgu_files(...)`
source(here("src/1-download-funcao-crawler-esic.R"))

# define parametros para passar no crawler
destino_dwld <- "C:\\Users\\rauld\\Documents\\negativas-acesso-informacao-Executivo-federal-2021-1\\dados\\raw"
a_minha_versao_do_chrome <- binman::list_versions("chromedriver")$win32[9]

# crawler
{
  download_cgu_files(ano = "2015", dest_file = destino_dwld, formato = "XML", versao_do_chrome = a_minha_versao_do_chrome); Sys.sleep(5);
  download_cgu_files(ano = "2016", dest_file = destino_dwld, formato = "XML", versao_do_chrome = a_minha_versao_do_chrome); Sys.sleep(5);
  download_cgu_files(ano = "2017", dest_file = destino_dwld, formato = "XML", versao_do_chrome = a_minha_versao_do_chrome); Sys.sleep(5);
  download_cgu_files(ano = "2018", dest_file = destino_dwld, formato = "XML", versao_do_chrome = a_minha_versao_do_chrome); Sys.sleep(5);
  download_cgu_files(ano = "2019", dest_file = destino_dwld, formato = "XML", versao_do_chrome = a_minha_versao_do_chrome); Sys.sleep(5);
  download_cgu_files(ano = "2020", dest_file = destino_dwld, formato = "XML", versao_do_chrome = a_minha_versao_do_chrome)
}

# anos <- as.character(2015:2021)
# walk2(.x = anos, .y = destino_dwld, .f = ~ download_cgu_files(ano = .x, dest_file = .y, formato = "XML", versao_do_chrome = a_minha_versao_do_chrome))

# check
"dados/raw" %>% 
  here() %>% 
  list.files(recursive = T, full.names = T) %>%
  map_df(file.info) %>% 
  rownames_to_column(var = "arquivo") %>% 
  as_tibble()
