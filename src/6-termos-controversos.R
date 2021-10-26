library(tidyverse)
library(lubridate)
library(glue)
library(here)

pedidos <- readRDS(here("dados/load/rds/pedidos-clean.rds"))
recursos <- readRDS(here("dados/load/rds/recursos-clean.rds"))

# termos controversos ----------------------------------------------------------

regex_lgpd <- 'lei geral de proteção de dados|lei de protecao de dados pessoais|13\\.?709|lgpd'

controversos <- pedidos %>% 
  rename(resposta_pedido = resposta) %>% 
  mutate(controversos_lgpd_resposta = str_detect(resposta_pedido, regex_lgpd),
         controversos_lgpd_pedido = str_detect(detalhamento_solicitacao, regex_lgpd))

controversos_lgpd <- controversos %>% 
  select(id_pedido, data_resposta, orgao = orgaodestinatario, contains("controversos_lgpd")) %>% 
  mutate(controverso_id = "LGPD")

saveRDS(controversos_lgpd, here("dados/load/rds/controversos_lgpd.rds"))

# controversos_desarrazoado = str_detect(resposta_pedido,'desarrazoado|desproporciona'), 
# controversos_fishing  = str_detect(resposta_pedido,'fishing'),
# controversos_seguranca =  str_detect(resposta_pedido,'segurança [nacional|do estado]'),
# controversos_sigilo = str_detect(resposta_pedido,'sigilo'),
# controversos_decisao =  str_detect(resposta_pedido,'processo decisorio em curso|documento preparatorio'),
# controversos_trabalho_adic = str_detect(resposta_pedido,'trabalho[s]? adiciona'),
# controversos_generico =  str_detect(resposta_pedido,'generico'),