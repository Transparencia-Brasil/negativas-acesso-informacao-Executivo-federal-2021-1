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

#path <- "cgu-interact/"
path <- ""

#' seletor de órgãos
choices <- sort(readRDS(here(glue("{path}data/select_orgao.rds"))))

#' contagens de pedidos
quantidades_orgao <- readRDS(here(glue("{path}data/count_pedidos.rds")))

#' Assuntos por decisão
assuntos_decisao <- readRDS(here(glue("{path}data/assuntos_decisao.rds"))) %>% 
  count(data_registro, orgao, decisao, assunto_pedido,
        name = "count_assunto_decisao_orgao_data") %>%
  group_by(data_registro, orgao, assunto_pedido) %>% 
  mutate(count_decisao_orgao_data = sum(count_assunto_decisao_orgao_data)) %>% 
  ungroup()

#' paletas de cores
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
            choices = seq.Date(ymd("2012-05-01"), ymd("2021-12-01"), by = "month"),
            selected = c(ymd("2012-05-01"), ymd("2021-12-01"))
          )
        ),
        mainPanel(
          tabsetPanel(
            tabPanel(
              "mês a mês - por decisão e órgão selecionado",
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
              "Acessos negados - top 10 órgãos",
              h2("% de acessos negados por órgão no período selecionado"),
              textOutput(outputId = ns("data_inicio2")),
              plotlyOutput(
                outputId = ns("top_10_acesso_negado"),
                width = "1000px",
                height = "600px"
              )
            ),
            tabPanel(
              "Acessos negados - órgão selecionado",
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
              ),
              hr(),
              h4("Assuntos mais frequêntes"),
              textOutput(outputId = ns("data_inicio5")),
              textOutput(outputId = ns("value5")),
              plotlyOutput(
                outputId = ns("assuntos_acesso_negado"),
                width = "800px",
                height = "600px"
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
          filter(between(data_registro, ymd(input$date_range[1]), ymd(input$date_range[2]))) %>%
          mutate(
            min_data = min(data_registro),
            max_data = max(data_registro)
          ) %>%
          complete(
            data_registro,
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
          filter(between(data_registro, ymd(input$date_range[1]), ymd(input$date_range[2])))
      })
      
      assuntos <- reactive({
        assuntos_decisao %>% 
          filter(between(data_registro, ymd(input$date_range[1]), ymd(input$date_range[2])))
      })
      
      output$lai_historico <- renderPlotly({
        validate(need(input$select_orgao, "Selecione um órgão"))
        
        my_plot <- count_pedidos_orgao() %>%
          ggplot(aes(
            x = data_registro,
            y = count_pedidos,
            fill = decisao,
            text = glue("Data resposta: {data_registro}<br>Quantidade: {count_pedidos}<br>Decisão: {decisao}<br>% do total: {round(per*100,2)}%")
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
            text = glue("{orgao} - {data_registro}<br>Quantidade de pedidos do orgao: {count_pedidos}<br>Quantidade de pedidos que o órgão negou: {count_pedidos_orgao}<br>Quantidade de acessos negados no período: {count_pedidos_decisao}")
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
            x = data_registro, 
            y = per_global,
            fill = decisao,
            text = glue("{orgao} - {data_registro}<br>Total pedidos do órgão: {count_pedidos_orgao}<br>Total pedidos do órgão com {decisao}: {count_pedidos}<br>Total de pedidos com {decisao} no FalaBr: {count_pedidos_decisao}")
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
            x = data_registro,
            y = per_interna,
            fill = decisao,
            text = glue("{orgao} - {data_registro}<br>Total pedidos do órgão: {count_pedidos_orgao}<br>Total pedidos do órgão com {decisao}: {count_pedidos}<br>Total de pedidos com {decisao} no FalaBr: {count_pedidos_decisao}")
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
      
      output$assuntos_acesso_negado <- renderPlotly({
        validate(need(input$select_orgao, "Selecione um órgão"))
        
        my_plot <- assuntos() %>% 
          filter(orgao == input$select_orgao) %>% 
          group_by(decisao, assunto_pedido) %>% 
          summarise(count_assunto_decisao_orgao = sum(count_assunto_decisao_orgao_data),
                    count_decisao_orgao = sum(count_decisao_orgao_data),
                    .groups = "drop") %>% 
          mutate(per = count_assunto_decisao_orgao) %>% 
          filter(decisao == "Acesso Negado") %>% 
          group_by(decisao, assunto_pedido) %>% 
          slice_max(order_by = count_assunto_decisao_orgao, n = 10) %>% 
          ungroup() %>% 
          ggplot(aes(
            x = reorder(assunto_pedido, per),
            y = per,
            fill = decisao,
            text = glue("{input$select_orgao}<br>Acessos negados neste assunto: {count_assunto_decisao_orgao}<br>Total pedidos do órgão com este assunto {count_decisao_orgao}")
          )) +
          geom_col() +
          coord_flip() +
          scale_fill_manual(values = cores_decisao) +
          theme_minimal() +
          labs(
            x = "Assunto",
            y = "Quantidade de acessos negados"
          )
        
        ggplotly(my_plot, tooltip = "text", dynamicTicks = T) %>% 
          layout(showlegend = F)
      })
    })
}

