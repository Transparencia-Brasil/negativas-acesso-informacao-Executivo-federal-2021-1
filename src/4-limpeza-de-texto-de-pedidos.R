library(tidyverse)
library(here)
library(glue)
library(lubridate)

source(here("src/3-funcao-limpando-texto.R"), encoding = "UTF-8")

#' base de dados de pedidos de acesso a informação, 
#' construída em um arquivo à parte chamado `pedidos-cgu-pre-processamento.R`
pedidos_clean <- "dados/load/rds/pedidos-cgu.rds" %>% 
  here() %>% 
  readRDS() %>% 
  transmute(
    id_pedido = id_pedido,
    data_registro = data_registro,
    data_resposta = data_resposta, 
    orgao = orgao,
    across(c(detalhamento, resposta, resumo), limpando_texto, .names = "{.col}_clean")
  )

#' base de dados de recursos, construída em um arquivo à
#'  parte chamado `pedidos-cgu-pre-processamento.R`
recursos_clean <- "dados/load/rds/recursos-cgu.rds" %>% 
  here() %>% 
  readRDS() %>% 
  transmute(
    id_pedido = id_pedido,
    id_recurso = id_recurso,
    data_registro = data_registro,
    data_resposta = data_resposta,
    instancia = instancia,
    across(c(desc_recurso, resposta_recurso), limpando_texto, .names = "{.col}_clean")
  )

#' salva
saveRDS(pedidos_clean, here("dados/load/rds/pedidos-clean.rds"))
saveRDS(recursos_clean, here("dados/load/rds/recursos-clean.rds"))
