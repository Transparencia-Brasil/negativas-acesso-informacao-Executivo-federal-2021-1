library(tidyverse)
library(here)
library(glue)
library(lubridate)

source(here("src/5-funcao-limpando-texto.R"))

#' testa
pedidos_clean <- readRDS(here("dados/load/rds/pedidos-clean.rds"))
recursos_clean <- readRDS(here("dados/load/rds/recursos-clean.rds"))

#' base com textos e todas as colunas
pedidos_cgu <- readRDS(here("dados/load/rds/pedidos-cgu.rds"))
recursos_cgu <- readRDS(here("dados/load/rds/recursos-cgu.rds"))

library(tidytext)

#' stopwords do pacote `tm`
stopwords_tm <- tibble(
  word = limpando_texto(tm::stopwords("pt")),
  lexicon = "tm"
)

#' stopwords adicionais
stopwords_lai <- tibble(
  word = c(
    "prezada",
    "prezado",
    "prezados",
    "prezadas",
    "senhor",
    "senhora",
    "ser",
    "atenciosamente",
    "ainda",
    "desde",
    "br",
    "n",
    "sr",
    "sra",
    "i",
    "ii",
    "iii",
    "iv"
  ),
  lexicon = "lai"
)

#' base de stopword completa
stopwords <- bind_rows(stopwords_tm, stopwords_lai)

#' pedidos tokenizados
tidy_pedidos <- pedidos_clean %>% 
  transmute(
    id_pedido,
    ano = year(data_resposta),
    assunto_pedido,
    orgao = orgaodestinatario,
    detalhamento_solicitacao,
    resposta
  ) %>% 
  filter(str_detect(orgao, "^INCRA\\s")) %>% 
  unnest_tokens(word, resposta)

#' respostas tokenizadas
tidy_resposta <- pedidos_clean %>% 
  transmute(
    id_pedido,
    ano = year(data_resposta),
    assunto_pedido,
    orgao = orgaodestinatario,
    detalhamento_solicitacao,
    resposta
  ) %>% 
  filter(str_detect(orgao, "^INCRA\\s")) %>% 
  unnest_tokens(word, resposta)

#' wordcloud
library(wordcloud)
tidy_resposta %>% 
  filter(ano == 2021) %>%
  mutate(
    word = word %>% 
      str_extract("[a-z']+") %>% 
      str_replace_all("^processos$", "processo") %>% 
      str_replace_all("^informacoes$", "informacao") %>% 
      str_replace_all("urlurlurl", "URL") %>% 
      str_replace_all("lai", "LAI") %>% 
      str_replace_all("lgpd", "LGPD")
  ) %>%
  anti_join(stopwords) %>% 
  count(ano, orgao, word, sort = TRUE) %>%
  with(wordcloud(word, n, max.words = 200))



glimpse()

transmute(
  id_pedido = id_pedido,
  across(c(detalhamento_solicitacao, resposta), limpando_texto, .names = "{.col}_clean")
)