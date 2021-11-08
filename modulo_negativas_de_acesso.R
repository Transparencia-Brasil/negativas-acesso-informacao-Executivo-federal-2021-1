library(glue)
library(here)

path <- "cgu-interact/"
#path <- ""

# helpers -----
choices <- sort(readRDS(here(glue("{path}data/select_orgao.rds"))))
quantidades_orgao <- readRDS(here(glue("{path}data/count_pedidos.rds")))
source(here(glue("{path}3-cores.R")))


modulo_negativas_de_acesso_UI <- function(id) {

  

}

modulo_negativas_de_acesso_server <- function(input, output, session) {
  # You can access the value of the widget with input$select, e.g.
  output$value <- renderPrint({
    input$select_orgao
  })
}

# my_lbl <- function(x) scales::percent(x, accuracy = .1, decimal.mark = ",")

# decisao_rect <- tibble(
#   xmin = ymd("2015-01-01"),
#   xmax = ymd("2021-07-01"),
#   ymin = -Inf,
#   ymax = Inf,
#   decisao = "Acesso Negado"
# )

# quantidades_orgao %>%
#   filter(str_detect(orgao, "^ME ") & decisao == "Acesso Negado") %>%
#   mutate(per = count_pedidos / count_pedidos_decisao) %>% 
#   ggplot(aes(x = data_resposta, y = per)) +
#   geom_rect(
#     data = decisao_rect,
#     aes(
#       xmin = xmin,
#       xmax = xmax,
#       ymin = ymin,
#       ymax = ymax,
#       fill = decisao
#     ),
#     alpha = .2,
#     show.legend = F,
#     inherit.aes = F
#   ) +
#   geom_line() +
#   geom_vline(xintercept = seq(ymd("2015-01-01"), ymd("2021-01-01"), by = "year"), lty = 3) +
#   geom_text(
#     data = tibble(data_resposta = seq(ymd("2015-02-01"), ymd("2021-02-01"), by = "year")),
#     aes(label = year(data_resposta), y = -.005),
#     size = 3,
#     vjust = .1,
#     hjust = .25,
#     color = "gray20"
#   ) +
#   ggrepel::geom_label_repel(
#     data = . %>%
#       group_by(decisao, year(data_resposta), orgao) %>%
#       arrange(year(data_resposta), decisao, -per) %>%
#       filter(row_number() == 1) %>%
#       ungroup(),
#     aes(label = my_lbl(per), fill = decisao, color = decisao),
#     min.segment.length = 0.5,
#     size = 3.2,
#     label.padding = unit(0.15, "lines"),
#     label.size = NA,
#     show.legend = F,
#     direction = "y"
#   ) +
#   geom_point(
#     data = . %>%
#       group_by(decisao, year(data_resposta), orgao) %>%
#       arrange(year(data_resposta), decisao, -per) %>%
#       filter(row_number() == 1) %>%
#       ungroup()
#   ) +
#   scale_fill_manual(values = cores_decisao) +
#   scale_color_manual(values = cores_decisao3) +
#   scale_y_percent(expand = c(0.2, 0)) +
#   scale_x_date(
#     limits = c(ymd("2015-01-01"), ymd("2021-07-01")),
#     breaks = scales::date_breaks("3 months"),
#     date_labels = "%b",
#     expand = c(0, 0)
#   ) +
#   theme_minimal() +
#   theme(
#     legend.position = "top",
#     axis.ticks.x = element_line(),
#     legend.text = element_text(size = 8),
#     axis.text.x = element_text(size = 10, vjust = 2.5, hjust = .5),
#     panel.grid.minor = element_blank(),
#     strip.text = element_text(size = 12, angle = 0, hjust = 0)
#   ) +
#   labs(
#     x = NULL,
#     y = NULL,
#     title = "Negativas de acesso a informação por órgão do executivo Federal",
#     subtitle = "Como % do total de decisões de acessos negados no FalaBr",
#     color = NULL,
#     fill = NULL
#   )


