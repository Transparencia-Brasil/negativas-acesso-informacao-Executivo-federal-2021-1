library(tidyverse)
library(lubridate)
library(glue)
library(here)

pedidos <- readRDS(here("dados/load/rds/pedidos_clean.rds"))
recursos <- readRDS(here("dados/load/rds/recursos_clean.rds"))

# termos controversos ----------------------------------------------------------

pedidos <- pedidos %>% 
  rename(resposta_pedido = resposta) %>% 
  mutate(
    controversos_desarrazoado = str_detect(resposta_pedido,'desarrazoado|desproporciona'), 
    controversos_fishing  = str_detect(resposta_pedido,'fishing'),
    controversos_seguranca =  str_detect(resposta_pedido,'segurança [nacional|do estado]'),
    controversos_sigilo = str_detect(resposta_pedido,'sigilo'),
    controversos_decisao =  str_detect(resposta_pedido,'processo decisorio em curso|documento preparatorio'),
    controversos_trabalho_adic = str_detect(resposta_pedido,'trabalho[s]? adiciona'),
    controversos_generico =  str_detect(resposta_pedido,'generico'),
    controversos_lgpd = str_detect(resposta_pedido, 'lei geral de proteção de dados|lei de protecao de dados pessoais|13\\.?709|13\\.?853|lgpd')
  )

pedidos %>% 
  select(id_pedido, starts_with("controversos")) %>% 
  pivot_longer(names_to = "controversos", cols = starts_with("controversos"), 
               values_to = "prevalencia", names_prefix = "controversos_")

