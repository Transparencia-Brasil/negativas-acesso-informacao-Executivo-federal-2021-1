library(tidyverse)
library(here)
library(glue)
library(lubridate)

source(here("src/5-funcao-limpando-texto.R"), encoding = "UTF-8")

#' base de dados de pedidos de acesso a informação, 
#' construída em um arquivo à parte chamado `pedidos-cgu-pre-processamento.R`
pedidos_clean <- "dados/load/rds/pedidos-cgu.rds" %>% 
  here() %>% 
  readRDS() %>% 
  transmute(
    id_pedido = id_pedido,
    across(c(detalhamento_solicitacao, resposta, resumo_solicitacao), limpando_texto, .names = "{.col}_clean")
  )

#' base de dados de recursos, construída em um arquivo à
#'  parte chamado `pedidos-cgu-pre-processamento.R`
recursos_clean <- "dados/load/rds/recursos-cgu.rds" %>% 
  here() %>% 
  readRDS() %>% 
  transmute(
    id_pedido = id_pedido,
    id_recurso = id_recurso,
    across(c(desc_recurso, resposta_recurso), limpando_texto, .names = "{.col}_clean")
  )

#' salva
saveRDS(pedidos_clean, here("dados/load/rds/pedidos_clean.rds"))
saveRDS(recursos_clean, here("dados/load/rds/recursos_clean.rds"))