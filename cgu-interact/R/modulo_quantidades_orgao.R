path <- "cgu-interact/"
#path <- ""

modulo_quantidades_orgao_UI <- function(id) {
  ns <- NS(id)
  
  # helpers -----
  choices <- sort(readRDS(here(glue("{path}data/select_orgao.rds"))))
  
  tagList(
    # juntar elementos de ui, empacotar e manda para a ui principal em app.R
    # sidebar ----
    sidebarPanel(
      selectizeInput(inputId = ns("select_orgao"),
                     label = "Digite o nome ou selecione um órgão",
                     choices = choices,
                     options = list(placeholder = "Digite/selecione um órgão",
                                    onInitialize = I('function() { this.setValue(""); }'))
      ),
      
      sliderTextInput(inputId = ns("date_range"),
                      label = "Selecione um intervalo de tempo:", 
                      choices = seq.Date(ymd("2015-01-01"), ymd("2021-12-01"), by = "month"),
                      selected = c(ymd("2015-01-01"), ymd("2021-12-01"))
      ),
      
      width = 3
    ),
    
    # main ----
    mainPanel(
      
      titlePanel("Pedidos de acesso a informação via LAI - CGU"),
      textOutput(outputId = ns("data_inicio")),
      plotlyOutput(outputId = ns("lai_historico"),
                   width = "1200px",
                   height = "850px")
      
    )
  
  )
}

modulo_quantidades_orgao_server <- function(input, output, session) {
  # You can access the value of the widget with input$select, e.g.
  output$value <- renderPrint({ input$select_orgao })
  
  output$data_inicio <- renderPrint({ 
    
    my_date_fmt <- function(x) format(as.Date(x), format = '%b.%Y')
    
    glue("Período: {my_date_fmt(input$date_range[1])} até {my_date_fmt(input$date_range[2])}")
    
  })
  
  count_pedidos_orgao <- reactive({
    
    readRDS(here(glue("{path}data/count_pedidos.rds"))) %>%
      filter(orgao == input$select_orgao) %>%
      filter(between(data_resposta, ymd(input$date_range[1]), ymd(input$date_range[2]))) %>% 
      mutate(min_data = min(data_resposta),
             max_data = max(data_resposta)) %>% 
      complete(data_resposta,
               orgao,
               decisao,
               fill = list(
                 count_pedidos = 0,
                 count_pedidos_total = 0,
                 per = 0
               )) %>% 
      filter(!(decisao %in% c(
        "Não se trata de solicitação de informação",
        "Pergunta Duplicada/Repetida"
      )))
    
  })
  
  output$lai_historico <- renderPlotly({
    
    validate(need(input$select_orgao, "Selecione um órgão"))
    
    source(here(glue("{path}3-cores.R")))
    
    my_plot <- count_pedidos_orgao() %>%
      ggplot(aes(x = data_resposta,
                 y = count_pedidos,
                 fill = decisao,
                 text = glue("Data resposta: {data_resposta}<br>Quantidade: {count_pedidos}<br>Decisão: {decisao}<br>% do total: {round(per*100,2)}%")
      )) +
      geom_col(show.legend = F) +
      facet_wrap(~ decisao, ncol = 1, scales = "free_x", drop = T) +
      labs(
        title = glue("{unique(count_pedidos_orgao()$orgao)}"),
        subtitle = "Quantidade absoluta de pedidos de acesso a informação via LAI",
        x = NULL,
        y = "Quantidade"
      ) +
      scale_fill_manual(values = cores_decisao) +
      theme_minimal()
    
    ggplotly(my_plot, tooltip = "text", dynamicTicks = T)
    
  })
}