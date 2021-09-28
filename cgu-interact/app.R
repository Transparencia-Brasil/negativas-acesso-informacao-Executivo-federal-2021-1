#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(here)
library(tidyverse)
library(here)
library(glue)
library(lubridate)
library(plotly)

choices <- sort(readRDS(here("cgu-interact/data/select_orgao.rds")))
source(here("cgu-interact/3-cores.R"))

count_pedidos <- readRDS(here("cgu-interact/data/count_pedidos.rds"))

# Define UI for application that draws a histogram
ui <- fluidPage(
        
    h1("Pedidos - CGU"),
    fluidRow(
        column(
            width = 4,
            # I() indicates it is raw JavaScript code that should be evaluated, instead
            # of a normal character string
            selectizeInput(
                "select_orgao",
                "Digite o nome ou selecione um órgão",
                choices = choices,
                options = list(
                    placeholder = "Digite/selecione um órgão",
                    onInitialize = I('function() { this.setValue(""); }')
                )
            )
        ),
        column(
            width = 8,
            plotOutput("lai_historico")
        )
        
    )
)




# Define server logic required to draw a histogram
server <- function(input, output) {
        
        # You can access the value of the widget with input$select, e.g.
        output$value <- renderPrint({input$select_orgao})
        
        count_pedidos_orgao <- reactive({
            count_pedidos %>% 
                filter(orgao == input$select_orgao) %>% 
                mutate(min_data = min(data_resposta),
                       max_data = max(data_resposta))
        })
        

        output$lai_historico <- renderPlot({
            validate(need(input$select_orgao, 'Selecione um órgão'))
            
            my_lbl <- function(x) scales::percent(x, accuracy = .1, decimal.mark = ",")
            
            decisao_rect <- tibble(
                xmin = ymd("2015-01-01"),
                xmax = ymd("2021-07-01"),
                ymin = -Inf,
                ymax = Inf,
                decisao = unique(count_pedidos$decisao)
            )
            
            count_pedidos_orgao() %>% 
                ggplot(aes(x = data_resposta, y = count_pedidos,
                           fill = decisao)) +
                # geom_rect(
                #     data = decisao_rect,
                #     aes(
                #         xmin = xmin,
                #         xmax = xmax,
                #         ymin = ymin,
                #         ymax = ymax,
                #         fill = decisao
                #     ),
                #     alpha = .2,
                #     show.legend = F
                # ) +
                geom_col(show.legend = F) +
                facet_wrap(~ decisao, ncol = 1) +
                labs(
                    title = glue("{unique(count_pedidos_orgao()$orgao)}"),
                    subtitle = "Quantidade absoluta de pedidos de acesso a informação via LAI",
                    x = NULL,
                    y = "Quantidade"
                    ) +
                scale_fill_manual(values = cores_decisao) +
                theme_minimal() +
                theme(
                    strip.text = element_text(hjust = 0)
                )
        }, height = 800, width = 700)
    }


# Run the application 
shinyApp(ui = ui, server = server)
