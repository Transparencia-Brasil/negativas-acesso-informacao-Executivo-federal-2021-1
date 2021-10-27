library(tidyverse)
library(here)
library(lubridate)

limpando_texto <- function(x) {
  
  url_pattern <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"

  x %>%
    tolower() %>%
    tm::removeWords(tm::stopwords("pt")) %>%
    stringi::stri_trans_general("Latin-ASCII") %>% 
    str_replace_all(url_pattern, "urlurlurl") %>%
    str_replace_all("\\r\\n", " ") %>%
    str_replace_all("\\n", " ") %>%
    str_replace_all("\\quot;", " ") %>% 
    str_replace_all("[[:punct:]]", " ") %>% 
    str_squish()

}

pedidos_cgu <- readRDS(here("dados/load/rds/pedidos-cgu.rds")) %>%
  mutate(across(starts_with("ts_"), ~ dmy(.x)),
         across(c(detalhamento_solicitacao, resposta), limpando_texto))

recursos_cgu <- readRDS(here("dados/load/rds/recursos-cgu.rds")) %>% 
  mutate(across(starts_with("ts_"), ~ dmy(.x)),
         across(c(desc_recurso, resposta_recurso), limpando_texto))

saveRDS(pedidos_cgu, here("dados/load/rds/pedidos_clean.rds"))
saveRDS(recursos_cgu, here("dados/load/rds/recursos_clean.rds"))

readRDS(here("dados/load/rds/pedidos-clean.rds"))
readRDS(here("dados/load/rds/recursos-clean.rds"))
