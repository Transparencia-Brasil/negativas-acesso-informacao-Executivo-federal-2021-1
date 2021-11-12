library(tidyverse)
library(here)
library(glue)
library(lubridate)

#' lista com as regex utilizadas, são construídas em um arquivo à parte chamado `lista-de-regex.R`
lista_de_regex <- readRDS(here("dados/load/rds/lista-de-regex.rds"))

#' helper para extrair regex da lista de regex
my_rgx <- function(df, id_rgx) filter(df, id == id_rgx) %>% pull(regex)

#' helper para extrair replacement da lista de regex
my_repl <- function(df, id_rgx) filter(df, id == id_rgx) %>% pull(replacement)

#' função que remove caracteres inúteis, pontuação, espaços, etc. 
#' Ela também faz o replacement para normalizar termos controversos
limpando_texto <- function(x) {
  x %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_urltag"),
                    my_repl(lista_de_regex, "rgx_urltag")) %>% 
    str_replace_all(my_rgx(lista_de_regex, "rgx_ddmmyyyy"),
                    my_repl(lista_de_regex, "rgx_ddmmyyyy")) %>% 
    tolower() %>%
    stringi::stri_trans_general("Latin-ASCII")  %>%
    str_replace_all("\\r\\n\\r\\n", " ") %>%
    str_replace_all("\\r\\n", " ") %>%
    str_replace_all("\\r\\r", " ") %>%
    str_replace_all("\\n\\r", " ") %>%
    str_replace_all("\\n", " ") %>%
    str_replace_all("\\r", " ") %>%
    str_replace_all("[:punct:]", " ") %>% 
    str_replace_all("°|º|ª|\\+", " ") %>%
    str_squish() %>% 
    str_replace_all(my_rgx(lista_de_regex, "rgx_anexo_corrompido"),
                    my_repl(lista_de_regex, "rgx_anexo_corrompido")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_covid"),
                    my_repl(lista_de_regex, "rgx_covid")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_dados_pessoais"),
                    my_repl(lista_de_regex, "rgx_dados_pessoais")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_decisao"),
                    my_repl(lista_de_regex, "rgx_decisao")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_desarrazoado"),
                    my_repl(lista_de_regex, "rgx_desarrazoado")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_fishing"),
                    my_repl(lista_de_regex, "rgx_fishing")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_generico"),
                    my_repl(lista_de_regex, "rgx_generico")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_inexistentes"),
                    my_repl(lista_de_regex, "rgx_inexistentes")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_lgpd"),
                    my_repl(lista_de_regex, "rgx_lgpd")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_nao_competencia"),
                    my_repl(lista_de_regex, "rgx_nao_competencia")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_resposta_incompleta"),
                    my_repl(lista_de_regex, "rgx_resposta_incompleta")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_seguranca_nacional"),
                    my_repl(lista_de_regex, "rgx_seguranca_nacional")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_sigilo"),
                    my_repl(lista_de_regex, "rgx_sigilo")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_trabalho_adicional"),
                    my_repl(lista_de_regex, "rgx_trabalho_adicional")) %>%
    str_replace_all(my_rgx(lista_de_regex, "rgx_lai"),
                    my_repl(lista_de_regex, "rgx_lai")) %>% 
    str_replace_all("(?<=\\d) +(?=\\d)", "") %>% 
    str_replace_all("lai( lai)*", "LAI") %>% 
    str_replace_all("lgpd( lgpd)*", "LGPD") %>% 
    str_extract("[a-z']+") %>% 
    str_replace_all("^processos$", "processo") %>% 
    str_replace_all("^informacoes$", "informacao") %>% 
    str_replace_all("urlurlurl", "URL")
}

#' base de dados de pedidos de acesso a informação, construída em um arquivo à parte chamado `pedidos-cgu-pre-processamento.R`
pedidos_clean <- readRDS(here("dados/load/rds/pedidos-cgu.rds")) %>% 
  transmute(
    id_pedido = id_pedido,
    across(c(detalhamento_solicitacao, resposta), limpando_texto, .names = "{.col}_clean")
  )

#' base de dados de recursos, construída em um arquivo à parte chamado `pedidos-cgu-pre-processamento.R`
recursos_clean <- readRDS(here("dados/load/rds/recursos-cgu.rds")) %>% 
  transmute(
    id_pedido = id_pedido,
    id_recurso = id_recurso,
    across(c(desc_recurso, resposta_recurso), limpando_texto, .names = "{.col}_clean")
  )

#' salva
saveRDS(pedidos_clean, here("dados/load/rds/pedidos_clean.rds"))
saveRDS(recursos_clean, here("dados/load/rds/recursos_clean.rds"))

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