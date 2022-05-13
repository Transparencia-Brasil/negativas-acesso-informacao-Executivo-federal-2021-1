library(tidyverse)
library(lubridate)
library(glue)
library(here)

pedidos  <- readRDS(here("dados/load/rds/pedidos-clean.rds"))
recursos <- readRDS(here("dados/load/rds/recursos-clean.rds"))

# termos controversos ----------------------------------------------------------

pedidos_controversos_lgpd <- pedidos %>% 
  rename(resposta_pedido = resposta_clean,
         detalhamento = detalhamento_clean,
         resumo = resumo_clean) %>% 
  mutate(controversos_lgpd_resposta = str_detect(resposta_pedido, "LGPD"),
         controversos_lgpd_pedido = str_detect(detalhamento, "LGPD")
         ) %>% 
  select(id_pedido, data_resposta, orgao, contains("controversos_lgpd")) %>% 
  mutate(
    controverso_id = "LGPD",
    tipo = case_when(
      controversos_lgpd_pedido & controversos_lgpd_resposta ~ "Pedido e reposta mencionam LGPD",
      controversos_lgpd_pedido & !controversos_lgpd_resposta ~ "Pedido menciona LGPD, resposta não",
      !controversos_lgpd_pedido & controversos_lgpd_resposta ~ "Pedido não menciona LGPD, resposta menciona",
      TRUE ~ "Não menciona LGPD"
    )
  )

# recursos_controversos
instancias_lvs <- c(
  "Primeira Instância",
  "Segunda Instância",
  "CGU",
  "CMRI",
  "Pedido de Revisão"
)
instancias_lvs <- ordered(instancias_lvs, levels = instancias_lvs)

recursos_controversos_lgpd <- recursos %>%  
  mutate(instancia = if_else(instancia == "Terceira Instância", "CGU", instancia),
         instancia = ordered(instancia, levels = instancias_lvs),
         controversos_lgpd_recurso = str_detect(desc_recurso_clean, "LGPD"),
         controversos_lgpd_resposta_recurso = str_detect(resposta_recurso_clean, "LGPD")
         ) %>% 
  select(id_pedido, id_recurso, data_resposta, instancia, contains("controversos_lgpd")) %>%
  mutate(
    controverso_id = "LGPD",
    tipo = case_when(
      controversos_lgpd_recurso & controversos_lgpd_resposta_recurso ~ "Pedido e reposta mencionam LGPD",
      controversos_lgpd_recurso & !controversos_lgpd_resposta_recurso ~ "Pedido menciona LGPD, resposta não",
      !controversos_lgpd_recurso & controversos_lgpd_resposta_recurso ~ "Pedido não menciona LGPD, resposta menciona",
      TRUE ~ "Não menciona LGPD"
  ))

saveRDS(pedidos_controversos_lgpd, here("dados/load/rds/pedidos-controversos-lgpd.rds"))
saveRDS(recursos_controversos_lgpd, here("dados/load/rds/recursos-controversos-lgpd.rds"))

# controversos_desarrazoado = str_detect(resposta_pedido,'desarrazoado|desproporciona'), 
# controversos_fishing  = str_detect(resposta_pedido,'fishing'),
# controversos_seguranca =  str_detect(resposta_pedido,'segurança [nacional|do estado]'),
# controversos_sigilo = str_detect(resposta_pedido,'sigilo'),
# controversos_decisao =  str_detect(resposta_pedido,'processo decisorio em curso|documento preparatorio'),
# controversos_trabalho_adic = str_detect(resposta_pedido,'trabalho[s]? adiciona'),
# controversos_generico =  str_detect(resposta_pedido,'generico'),