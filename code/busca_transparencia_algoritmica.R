library(tidyverse)
library(lubridate)

# Pedidos CGU:
pedidos_cgu <- read_csv("./data/pedidos_cgu.csv")  %>%
  mutate(
    DataRegistro = dmy_hms(DataRegistro) %>% as_date(),
    DataResposta = dmy_hms(DataResposta) %>% as_date()
  ) %>% 
  select(
    IdPedido,
    ProtocoloPedido,
    DetalhamentoSolicitacao,
    OrgaoDestinatario,
    DataRegistro,
    TipoResposta,
    Resposta
  )

# termos IA: 
#   i. algoritmo;
#  ii. inteligência artificial;
# iii. reconhecimento facial.
termos_IA <- c( 
  "algoritmo",
  "intelig[e|ê]ncia artifical",
  "reconhecimento facial"
  ) %>%
  paste0(collapse = "|")

# Filtro
pedidos_com_termos_IA <- pedidos_cgu %>% filter(str_detect(tolower(DetalhamentoSolicitacao), termos_IA))

# inspec
glimpse(pedidos_com_termos_IA)

# flags termos:
pedidos_com_termos_IA <- pedidos_com_termos_IA %>%
  mutate(
    termo_algoritmo = ifelse(str_detect(DetalhamentoSolicitacao, "algoritmo"),
                             "Possui o termo", "Não possui o termo"),
    termo_intelig_art = ifelse(str_detect(DetalhamentoSolicitacao, "intelig[e|ê]ncia artifical"),
                               "Possui o termo", "Não possui o termo"),
    termo_recon_facial = ifelse(str_detect(DetalhamentoSolicitacao, "reconhecimento facial"),
                                "Possui o termo", "Não possui o termo")
  )

# Plotar por ano:
pedidos_com_termos_IA %>%
  mutate(ano = floor_date(DataRegistro, unit = "year")) %>%
  group_by(ano) %>%
  summarise(qt_pedidos = n()) %>%
  ungroup() %>%
  ggplot(aes(x = ano, y = qt_pedidos)) +
  geom_text(aes(label = qt_pedidos), vjust = -1) +
  geom_col() +
  theme_bw() +
  ylim(c(0,60)) +
  labs(x = NULL, y = NULL,
       title = "Quantidade de pedidos com termos relacionados a Inteligência Artificial",
       subtitle = "Termos: 'Algoritmo', 'Inteligência Artificial', 'Reconhecimento Facial'",
       caption = "2020 até 22/07/2020")


# pega os Ids de pedidos com termos IA:
ids <- pedidos_com_termos_IA %>% select(IdPedido) %>% pull()

# Recursos  
recursos_IA <- read_csv("./data/recursos_cgu.csv") %>%
  filter(IdPedido %in% ids) %>%
  mutate(
    DataRegistro = dmy_hms(DataRegistro) %>% as_date(),
    DataResposta = dmy_hms(DataResposta) %>% as_date(),
    Instancia = factor(Instancia, levels = c("Primeira Instância",
                                             "Segunda Instância", 
                                             "CGU", "CMRI", "Pedido de Revisão")),
    TipoResposta = case_when(is.na(TipoResposta) ~ "NA", TRUE ~ TipoResposta),
    TipoResposta = factor(TipoResposta, levels = c("Deferido", "Parcialmente deferido",
                                                   "Indeferido", "Não conhecimento", 
                                                   "Perda de objeto", "Perda de objeto parcial",
                                                   "Acolhimento", "NA"))
  ) %>% 
  select(
    IdRecurso,
    IdRecursoPrecedente,
    IdPedido,
    DescRecurso,
    RespostaRecurso,
    Instancia,
    TipoResposta
  )
  

# Os pedidos foram para:
recursos_IA %>% count(Instancia)

# Respostas por instancia
recursos_1a_instancia <- recursos_IA %>%
  filter(Instancia == "Primeira Instância") %>%
  select(
    IdPedido,
    recurso_1a_instancia = DescRecurso,
    recurso_1a_instancia_resp = RespostaRecurso
  )

recursos_2a_instância <- recursos_IA %>%
  filter(Instancia == "Segunda Instância") %>%
  select(
    IdPedido,
    recurso_2a_instancia = DescRecurso,
    recurso_2a_instancia_resp = RespostaRecurso
  )

recursos_CGU <- recursos_IA %>%
  filter(Instancia == "CGU") %>%
  select(
    IdPedido,
    recurso_CGU = DescRecurso,
    recurso_CGU_resp = RespostaRecurso
  )

pedidos_com_termos_IA  <- pedidos_com_termos_IA %>%
  left_join(recursos_1a_instancia, by="IdPedido") %>%
  left_join(recursos_2a_instância, by="IdPedido") %>%
  left_join(recursos_CGU, by="IdPedido")

library(xlsx)
write.xlsx(as.data.frame(pedidos_com_termos_IA), "./data/pedidos_com_termos_IA.xlsx")
