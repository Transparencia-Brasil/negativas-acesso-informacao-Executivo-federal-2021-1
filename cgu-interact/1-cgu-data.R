library(tidyverse)
library(here)
library(glue)
library(lubridate)

setwd(here())

#' base de dados anonimizada (2015-2021)
pedidos_cgu <- readRDS(here("dados/load/rds/pedidos-cgu.rds")) %>% 
  rename(orgao = orgaodestinatario)

#' base de dados completa (2012-2021)
pedidos_painel <- "dados/load/rds/base_cgu.rds" %>% 
  here() %>% 
  readRDS() %>%
  pluck("pedidos") %>%
  janitor::clean_names() %>% 
  mutate(
    ts_registro = data_registro,
    ts_resposta = data_resposta,
    data_registro = dmy(data_registro) %>% floor_date(unit = "month"),
    data_resposta = dmy(data_resposta) %>% floor_date(unit = "month")) %>% 
  rename(orgao = orgao_destinatario) %>%
  filter(!is.na(decisao), !is.na(data_resposta))

#' seletor de órgão
select_orgao <- unique(pedidos_painel$orgao)

#' contagem de pedidos
count_pedidos <- pedidos_painel %>% 
  count(data_registro, orgao, decisao, name = "count_pedidos") %>% 
  mutate(decisao = fct_reorder(decisao, count_pedidos, sum, .desc = TRUE)) %>% 
  filter(!decisao %in% c(
    "Pergunta Duplicada/Repetida",
    "Não se trata de solicitação de informação"
  )) %>% 
  add_count(data_registro, orgao, wt = count_pedidos, name = "count_pedidos_orgao") %>%  
  add_count(data_registro, decisao, wt = count_pedidos, name = "count_pedidos_decisao") %>% 
  add_count(data_registro, wt = count_pedidos, name = "count_pedidos_total")

#' assuntos
assuntos_decisao <- pedidos_painel %>%
  select(id_pedido, orgao, data_registro, decisao, assunto_pedido) %>% 
  filter(!decisao %in% c(
    "Pergunta Duplicada/Repetida",
    "Não se trata de solicitação de informação"
  ))

#' seletor de órgãos
saveRDS(select_orgao, here("cgu-interact/data/select_orgao.rds"))

#' contagem de pedidos
saveRDS(count_pedidos, here("cgu-interact/data/count_pedidos.rds"))

#' assuntos por data e decisão
saveRDS(assuntos_decisao, here("cgu-interact/data/assuntos_decisao.rds"))
