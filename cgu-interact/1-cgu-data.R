library(tidyverse)
library(here)
library(glue)
library(lubridate)

setwd(here())

pedidos_cgu <- readRDS(here("dados/load/rds/pedidos-cgu.rds"))
pedidos_clean <- readRDS(here("dados/load/rds/pedidos-clean.rds"))
select_orgao <- unique(pedidos_cgu$orgaodestinatario)

count_pedidos <- pedidos_cgu %>% 
  count(data_resposta, orgao = orgaodestinatario, decisao, name = "count_pedidos") %>% 
  mutate(decisao = fct_reorder(decisao, count_pedidos, sum, .desc = TRUE)) %>% 
  filter(!decisao %in% c(
    "Pergunta Duplicada/Repetida",
    "Não se trata de solicitação de informação"
  )) %>% 
  add_count(data_resposta, orgao, wt = count_pedidos, name = "count_pedidos_orgao") %>%  
  add_count(data_resposta, decisao, wt = count_pedidos, name = "count_pedidos_decisao") %>% 
  add_count(data_resposta, wt = count_pedidos, name = "count_pedidos_total")

# regex que detecta URL
rgx_url <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"

# regex que detecta data (ex: dd/mm/aaaa)
rgx_data <- "\\d{2}.\\d{2}.\\d{4}"

# regex quando pedido menciona LGPD
rgx_lgpd <- c(
  "lei geral de protecao de dados",
  "lei de protecao de dados pessoais",
  "lgpd",
  "13709"
) %>% paste(collapse = "|")

# regex quando faz menção a LAI
rgx_lai <- c(
  "lei de acesso a informacao",
  "lai",
  "12527"
) %>% paste(collapse = "|")

conteudo_acesso_negado <- pedidos_clean %>%
  select(
    id_pedido,
    data_resposta,
    orgao = orgaodestinatario,
    decisao,
    assunto_pedido,
    detalhamento_solicitacao,
    resposta
  ) %>%
  filter(decisao == "Acesso Negado") %>%
  pivot_longer(-c(id_pedido:assunto_pedido), names_to = "interacao", values_to = "text") %>%
  mutate(
    
    text = text %>% 
      tolower() %>%
      stringi::stri_trans_general("Latin-ASCII") %>%
      str_replace_all("\\r\\n\\r\\n", " ") %>%
      str_replace_all("\\r\\n", " ") %>%
      str_replace_all("\\r\\r", " ") %>%
      str_replace_all("\\n\\r", " ") %>%
      str_replace_all("\\n", " ") %>%
      str_replace_all("\\r", " ") %>%
      str_replace_all("[:punct:]", " ") %>%
      str_replace_all("°|º|ª", " ") %>%
      str_squish() %>%
      str_replace_all(rgx_url, "urltag") %>%
      str_replace_all(rgx_data, "ddmmyyyy") %>%
      str_replace_all(rgx_lgpd, "lgpd") %>%
      str_replace_all(rgx_lai, "lai") %>%
      str_replace_all("lgpd( lgpd)+", "lgpd") %>%
      str_replace_all("lai( lai)+", "lai")
    
  ) %>% 
  tidytext::unnest_tokens(word, text) %>%
  anti_join(tibble(word = tm::stopwords("pt"))) %>% 
  mutate(word = str_extract(word, "[a-z]+")) %>% 
  na.omit() %>% 
  filter(!is.na(word) & !str_detect(word, "^.$"))

pedidos_por_data <- pedidos_cgu %>% 
  transmute(id_ano_base,
            orgao = orgaodestinatario,
            decisao,
            ts_registro = dmy(ts_registro),
            ts_resposta = dmy(ts_resposta))

saveRDS(select_orgao, here("cgu-interact/data/select_orgao.rds"))
saveRDS(count_pedidos, here("cgu-interact/data/count_pedidos.rds"))
saveRDS(pedidos_por_data, here("cgu-interact/data/pedidos_por_data.rds"))
saveRDS(conteudo_acesso_negado, here("cgu-interact/data/conteudo_acesso_negado.rds"))

pedidos_por_data <- readRDS(here("cgu-interact/data/pedidos_por_data.rds"))

