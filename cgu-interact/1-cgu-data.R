library(tidyverse)
library(here)
library(glue)
library(lubridate)

setwd(here())

pedidos_cgu <- readRDS(here("dados/load/rds/pedidos-cgu.rds"))
select_orgao <- unique(pedidos_cgu$orgaodestinatario)

count_pedidos <- pedidos_cgu %>% 
  count(data_resposta, orgao = orgaodestinatario, decisao, name = "count_pedidos") %>% 
  mutate(decisao = fct_reorder(decisao, count_pedidos, sum, .desc = TRUE)) %>% 
  filter(!decisao %in% c(
    "Pergunta Duplicada/Repetida",
    "Não se trata de solicitação de informação"
  )) %>% 
  add_count(data_resposta, wt = count_pedidos, name = "count_pedidos_total") %>% 
  mutate(per = count_pedidos / count_pedidos_total)

pedidos_por_data <- pedidos_cgu %>% 
  transmute(id_ano_base,
            orgao = orgaodestinatario,
            decisao,
            ts_registro = dmy(ts_registro),
            ts_resposta = dmy(ts_resposta))

saveRDS(select_orgao, here("data/select_orgao.rds"))
saveRDS(count_pedidos, here("data/count_pedidos.rds"))
saveRDS(pedidos_por_data, here("cgu-interact/data/pedidos_por_data.rds"))


pedidos_por_data <- readRDS(here("cgu-interact/data/pedidos_por_data.rds"))


