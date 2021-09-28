library(tidyverse)
library(here)
library(glue)

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

saveRDS(select_orgao, here("cgu-interact/select_orgao.rds"))
saveRDS(count_pedidos, here("cgu-interact/count_pedidos.rds"))
