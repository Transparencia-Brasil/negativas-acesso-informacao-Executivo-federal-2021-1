# converte cvs para rds:

pedidos_cgu <- read_csv("../data/pedidos_cgu.csv")
saveRDS(pedidos_cgu, "/data/pedidos_cgu.rds")

recursos_cgu <- read_csv("../data/recursos_cgu.csv")
saveRDS(recursos_cgu, "/data/recursos_cgu.rds")
