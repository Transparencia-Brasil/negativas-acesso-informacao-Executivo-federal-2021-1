#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

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


# Define UI for application that draws a histogram
ui <- fluidPage(
  modulo_quantidades_orgao_UI("modulo_quantidades_orgao_ui")
)

server <- function(input, output) {
  modulo_quantidades_orgao_server("modulo_quantidades_orgao_ui")
}

# Run the application 
shinyApp(ui = ui, server = server)

