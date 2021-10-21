setwd(here("cgu-interact"))
plot_count_pedidos <- function(orgao) {
  
  count_pedidos <- readRDS(here("data/count_pedidos.rds")) %>% 
    filter(orgao == orgao)
  
  nm_orgao <- unique(count_pedidos$orgao)
  
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
      "Não se trata de solicitação de informação" = cores_aep[["marrom"]],
      "Acesso Negado" = cores_aep[["rosa"]],
      "Acesso Parcialmente Concedido" = cores_aep[["laranja"]],
      "Pergunta Duplicada/Repetida" = cores_aep[["cinza"]],
      "Órgão não tem competência para responder sobre o assunto" = cores_tb[["cinza_escuro"]],
      "Informação Inexistente" = cores_tb[["cinza_quase_branco"]]
    )
    
    cores_decisao2 <- cores_decisao
    cores_decisao2[["Informação Inexistente"]] <- "gray20"
    
    cores_decisao3 <- c("black", "gray90", "gray20", "gray80", "gray20")
    names(cores_decisao3) <- names(cores_decisao)[-c(5, 2)] 
  # fim cores  
  
  # plot -----------------------------------------------------------------------
  p <- count_pedidos %>% 
    ggplot(aes_string(x = "data_resposta", y = "count_pedidos")) +
    geom_rect(
      data = . %>% 
        filter(data_resposta == min(data_resposta) | 
                 data_resposta == max(data_resposta)),
      aes_string(
        xmin = min("data_resposta"),
        xmax = max("data_resposta"),
        ymin = -Inf,
        ymax = Inf,
        fill = "decisao"
      ),
      alpha = .2,
      show.legend = F
    ) +
    geom_col(show.legend = F, size = .7)  +
    facet_wrap(~ decisao, scales = 'free', ncol = 1) +
    geom_vline(xintercept = seq(ymd('2015-01-01'), ymd('2021-01-01'), by = 'year'), lty = 3) +
    geom_text(
      data = . %>% 
        mutate(y_label = max(count_pedidos_total) * 1.1) %>%
        filter(month(data_resposta) == 2),
      aes(label = year(data_resposta), y = y_label),
      size = 3,
      vjust = .1,
      hjust = .25,
      color = "gray20"
    ) +
    geom_text(
      data = . %>% filter(count_pedidos == max(count_pedidos)),
      aes(label = "Máximas\nanuais"),
      color = "gray40",
      angle = 45,
      size = 1.5,
      hjust = 0,
      vjust = -.6,
      lineheight = 1
    ) +
    ggrepel::geom_label_repel(
      data = . %>%
        group_by(decisao, year(data_resposta)) %>%
        arrange(year(data_resposta), decisao, -count_pedidos) %>%
        filter(row_number() == 1) %>%
        ungroup(),
      aes(label = count_pedidos, fill = decisao, color = decisao),
      min.segment.length = 0.01,
      size = 3.2,
      label.padding = unit(0.1, "lines"),
      label.size = NA,
      show.legend = F,
      direction = "y"
    ) +
    geom_point(
      data = . %>%
        group_by(decisao, year(data_resposta)) %>%
        arrange(year(data_resposta), decisao, -count_pedidos) %>%
        filter(row_number() == 1) %>%
        ungroup()
    )  +
    scale_fill_manual(values = cores_decisao) +
    scale_color_manual(values = cores_decisao3) +
    scale_y_continuous(limits = c(0, max(count_pedidos$count_pedidos)*1.1)) +
    scale_x_date(
      breaks = scales::date_breaks("3 months"),
      date_labels = "%b",
      expand = c(0, 0)
    ) +
    theme_minimal() +
    theme(
      legend.position = "top",
      axis.ticks.x = element_line(), 
      legend.text = element_text(size = 8),
      axis.text.x = element_text(size = 10, vjust = 2.5, hjust = .5),
      panel.grid.minor = element_blank(),
      strip.text = element_text(size = 12, angle = 0, hjust = 0)
    ) +
    labs(
      x = NULL,
      y = "Quantidade de pedidos",
      title = glue("{orgao}"),
      subtitle = "Pedidos de acesso a informação via LAI - mês a mês",
      color = NULL,
      fill = NULL
    )
  
  return(p)
  
}
