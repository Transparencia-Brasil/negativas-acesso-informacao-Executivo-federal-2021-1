# cores ----------------------------------------------------------------------  
# aplica identidade visual da TB/AeP:
cores_aep <- c(
  laranja = "#F9A521",
  rosa = "#D81755",
  cinza = "#969696",
  marrom = "#B27D5C"
)

cores_tb <- c(
  laranja = "#F6A323",
  cinza_escuro = "#1d1d1b",
  cinza_claro = "#6f7171",
  cinza_quase_branco = "#ececec",
  azul = "#41ACBD"
)

cores_decisao <- c(
  "Acesso Concedido" = cores_tb[["azul"]],
  #"Não se trata de solicitação de informação" = cores_aep[["marrom"]],
  "Acesso Negado" = cores_aep[["rosa"]],
  "Acesso Parcialmente Concedido" = cores_aep[["laranja"]],
  #"Pergunta Duplicada/Repetida" = cores_aep[["cinza"]],
  "Órgão não tem competência para responder sobre o assunto" = cores_tb[["cinza_escuro"]],
  "Informação Inexistente" = cores_tb[["cinza_quase_branco"]]
)

cores_decisao2 <- cores_decisao
cores_decisao2[["Informação Inexistente"]] <- "gray20"

cores_decisao3 <- c("black", "gray90", "gray20", "gray80", "gray20")
names(cores_decisao3) <- names(cores_decisao)
# fim cores