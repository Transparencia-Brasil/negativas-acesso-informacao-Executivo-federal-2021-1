library(shiny)
library(shinyjs)
library(shinyWidgets)
library(here)
library(tidyverse)
library(here)
library(glue)
library(lubridate)
library(plotly)
library(wordcloud)

path <- "cgu-interact/"
#path <- ""

# helpers -----
choices <- sort(readRDS(here(glue("{path}data/select_orgao.rds"))))
quantidades_orgao <- readRDS(here(glue("{path}data/count_pedidos.rds")))
conteudo_acesso_negado <- readRDS(here(glue("{path}data/conteudo_acesso_negado.rds")))
source(here(glue("{path}3-cores.R")), encoding = "utf-8")

modulo_quantidades_orgao_UI <- function(id) {
  ns <- NS(id)

  tagList(
    # juntar elementos de ui, empacotar e manda para a ui principal em app.R
    fluidPage(
      sidebarLayout(
        position = "left",
        sidebarPanel(
          selectizeInput(
            inputId = ns("select_orgao"),
            label = "Digite o nome ou selecione um órgão",
            choices = choices,
            options = list(
              placeholder = "Digite/selecione um órgão",
              onInitialize = I('function() { this.setValue(""); }')
            )
          ),
          hr(),
          sliderTextInput(
            inputId = ns("date_range"),
            label = "Selecione um intervalo de tempo:",
            choices = seq.Date(ymd("2015-01-01"), ymd("2021-12-01"), by = "month"),
            selected = c(ymd("2015-01-01"), ymd("2021-12-01"))
          )
        ),
        mainPanel(
          tabsetPanel(
            tabPanel(
              "mês a mês - por decisão",
              h2("Quantidade de pedidos mês a mês - por decisão"),
              textOutput(outputId = ns("data_inicio1")),
              textOutput(outputId = ns("value1")),
              plotlyOutput(
                outputId = ns("lai_historico"),
                width = "1100px",
                height = "750px"
              )
            ),
            tabPanel(
              "Acessos negados (top 10)",
              h2("Acessos negados - por mês"),
              textOutput(outputId = ns("data_inicio2")),
              plotlyOutput(
                outputId = ns("top_10_acesso_negado"),
                width = "1000px",
                height = "600px"
              )
            ),
            tabPanel(
              "Acessos negados - histórico",
              h4("Acessos negados em relação ao total de negativas no FalaBr"),
              textOutput(outputId = ns("data_inicio3")),
              textOutput(outputId = ns("value3")),
              plotlyOutput(
                outputId = ns("acesso_negado_global"),
                width = "1000px",
                height = "400px"
              ),
              hr(),
              h4("Acessos negados em relação ao total de pedidos encaminhados ao órgão"),
              textOutput(outputId = ns("data_inicio4")),
              textOutput(outputId = ns("value4")),
              plotlyOutput(
                outputId = ns("acesso_negado_interna"),
                width = "1000px",
                height = "400px"
              )
            ),
            tabPanel(
              "Wordcloud - Acesso Negado",
              h3("Wordcloud termos utilizados no pedido e na resposta"),
              textOutput(outputId = ns("data_inicio5")),
              textOutput(outputId = ns("value5")),
              h4("Pedido"),
              plotOutput(
                outputId = ns("wordcloud_negativas_pedido"),
                width = "700px",
                height = "700px"
              ),
              hr(),
              h4("Resposta"),
              plotOutput(
                outputId = ns("wordcloud_negativas_resposta"),
                width = "700px",
                height = "700px"
              ),              
              hr(),
              h4("Assuntos mais frequêntes"),
              plotlyOutput(
                outputId = ns("assuntos_acesso_negado"),
                width = "700px",
                height = "700px"
              )
            )
          )
        )
      )
    )
  )
}

modulo_quantidades_orgao_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      # # You can access the value of the widget with input$select, e.g.

      output$value1 <- renderPrint({
        validate(need(input$select_orgao, ""))
        glue("Órgão: {input$select_orgao}")
        })
      output$value2 <- renderPrint({
        validate(need(input$select_orgao, ""))
        glue("Órgão: {input$select_orgao}")
      })
      output$value3 <- renderPrint({
        validate(need(input$select_orgao, ""))
        glue("Órgão: {input$select_orgao}")
      })
      output$value4 <- renderPrint({
        validate(need(input$select_orgao, ""))
        glue("Órgão: {input$select_orgao}")
      })
      output$value5 <- renderPrint({
        validate(need(input$select_orgao, ""))
        glue("Órgão: {input$select_orgao}")
      })

      my_date_fmt <- function(x) format(as.Date(x), format = "%b.%Y")
      dt_ini <- reactive({
        glue("Período: {my_date_fmt(input$date_range[1])} até {my_date_fmt(input$date_range[2])}")
      })

      output$data_inicio1 <- renderPrint({dt_ini()})
      output$data_inicio2 <- renderPrint({dt_ini()})
      output$data_inicio3 <- renderPrint({dt_ini()})
      output$data_inicio4 <- renderPrint({dt_ini()})
      output$data_inicio5 <- renderPrint({dt_ini()})

      count_pedidos_orgao <- reactive({
        quantidades_orgao %>%
          mutate(per = count_pedidos / count_pedidos_total) %>%
          filter(orgao == input$select_orgao) %>%
          filter(between(data_resposta, ymd(input$date_range[1]), ymd(input$date_range[2]))) %>%
          mutate(
            min_data = min(data_resposta),
            max_data = max(data_resposta)
          ) %>%
          complete(
            data_resposta,
            orgao,
            decisao,
            fill = list(
              count_pedidos = 0,
              count_pedidos_total = 0,
              per = 0
            )
          ) %>%
          filter(!(decisao %in% c(
            "Não se trata de solicitação de informação",
            "Pergunta Duplicada/Repetida"
          )))
      })

      acesso_negado <- reactive({
        quantidades_orgao %>%
          filter(decisao == "Acesso Negado") %>%
          mutate(per_global = count_pedidos / count_pedidos_decisao,
                 per_interna = count_pedidos / count_pedidos_orgao) %>%
          filter(between(data_resposta, ymd(input$date_range[1]), ymd(input$date_range[2])))
      })
      
      wordcloud_negativas_pedido <- reactive({
        validate(need(input$select_orgao, "Selecione um órgão"))
        set.seed(43)
        conteudo_acesso_negado %>%
          filter(interacao == "detalhamento_solicitacao") %>% 
          filter(orgao == input$select_orgao) %>%
          filter(between(data_resposta, ymd(input$date_range[1]), ymd(input$date_range[2])))
      })

      wordcloud_negativas_resposta <- reactive({
        validate(need(input$select_orgao, "Selecione um órgão"))
        set.seed(43)
        conteudo_acesso_negado %>%
          filter(interacao == "resposta") %>% 
          filter(orgao == input$select_orgao) %>%
          filter(between(data_resposta, ymd(input$date_range[1]), ymd(input$date_range[2])))
      })

      output$lai_historico <- renderPlotly({
        validate(need(input$select_orgao, "Selecione um órgão"))

        my_plot <- count_pedidos_orgao() %>%
          ggplot(aes(
            x = data_resposta,
            y = count_pedidos,
            fill = decisao,
            text = glue("Data resposta: {data_resposta}<br>Quantidade: {count_pedidos}<br>Decisão: {decisao}<br>% do total: {round(per*100,2)}%")
          )) +
          geom_col(show.legend = F) +
          facet_wrap(~decisao, ncol = 1, scales = "free_x", drop = T) +
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

      output$top_10_acesso_negado <- renderPlotly({

        my_plot <- acesso_negado() %>%
          slice_max(n = 10, order_by = per_global, with_ties = FALSE) %>% 
          mutate(orgao_rank = glue("{row_number()}º - {orgao}")) %>% 
          ggplot(aes(
            x = reorder(orgao_rank, per_global),
            y = per_global,
            fill = per_global,
            text = glue("{orgao} - {data_resposta}<br>Quantidade de pedidos do orgao: {count_pedidos}<br>Quantidade de pedidos que o órgão negou: {count_pedidos_orgao}<br>Quantidade de acessos negados no período: {count_pedidos_decisao}")
          )) +
          geom_col(color = "gray40") +
          scale_fill_gradient(low = "white", high = cores_decisao[["Acesso Negado"]]) +
          coord_flip() +
          theme_minimal() +
          labs(
            x = NULL,
            y = "% de acessos negados do órgão em relação\nao total de acessos negados no mês",
            fill = "%"
          )
        
        ggplotly(my_plot, tooltip = "text", dynamicTicks = T) %>% 
          layout(
            xaxis = list(tickformat = '%', range = c(0, 100)), 
            showlegend = F
          )

      })

      output$acesso_negado_global  <- renderPlotly({
        validate(need(input$select_orgao, "Selecione um órgão"))

        my_plot <- acesso_negado() %>% 
        filter(orgao == input$select_orgao) %>%
        ggplot(aes(
          x = data_resposta, 
          y = per_global,
          fill = decisao,
          text = glue("{orgao} - {data_resposta}<br>Total pedidos do órgão: {count_pedidos}<br>Total pedidos do órgão com {decisao}: {count_pedidos_orgao}<br>Total de pedidos com {decisao} no FalaBr: {count_pedidos_decisao}")
        )) +
        geom_col(show.legend = F) +
        scale_fill_manual(values = cores_decisao[["Acesso Negado"]]) +
        geom_point() +
        theme_minimal() +
        labs(
          y = "% em relação ao total\nde acessos negados no FalaBr",
          x = NULL
        )

        ggplotly(my_plot, tooltip = "text", dynamicTicks = T) %>% 
          layout(
            yaxis = list(tickformat = '%', range = c(0, 100)), 
            showlegend = F
          )

      })

      output$acesso_negado_interna <- renderPlotly({
        validate(need(input$select_orgao, "Selecione um órgão"))

        my_plot <- acesso_negado() %>% 
        filter(orgao == input$select_orgao) %>%
        ggplot(aes(
          x = data_resposta,
          y = per_interna,
          fill = decisao,
          text = glue("{orgao} - {data_resposta}<br>Total pedidos do órgão: {count_pedidos}<br>Total pedidos do órgão com {decisao}: {count_pedidos_orgao}<br>Total de pedidos com {decisao} no FalaBr: {count_pedidos_decisao}")
        )) +
        geom_col() +
        scale_fill_manual(values = cores_decisao[["Acesso Negado"]]) +
        geom_point() +
        theme_minimal() +
        labs(
          y = "% percentual em relação ao total\nde pedidos feitos ao órgão",
          x = NULL
        )

        ggplotly(my_plot, tooltip = "text", dynamicTicks = T) %>% 
          layout(
            yaxis = list(tickformat = '%', range = c(0, 100)),
            showlegend = F
          )
      })

      output$wordcloud_negativas_pedido <- renderPlot({
        wordcloud_negativas_pedido() %>%
          count(word, sort = T) %>%
          with(wordcloud(word, n, max.words = 150))
      })

      output$wordcloud_negativas_resposta <- renderPlot({
        wordcloud_negativas_resposta() %>%
          count(word, sort = T) %>%
          with(wordcloud(word, n, max.words = 150))
      })

      output$assuntos_acesso_negado <- renderPlotly({

        wordcloud_negativas_pedido() %>% 
          distinct(id_pedido, assunto_pedido) %>% 
          count(assunto_pedido) %>% 
          slice_max(order_by = n, n = 10) %>% 
          ggplot(aes(x = reorder(assunto_pedido, -n), y = n, fill = n)) +
          geom_col(color = 'gray40') +
          coord_flip() +
          scale_fill_gradient(low = "white", high = cores_decisao[["Acesso Negado"]]) +
          theme_minimal() +
          labs(
            x = NULL,
            y = "Quantidde",
            fill = NULL
          )
      })

    }
  )
}

