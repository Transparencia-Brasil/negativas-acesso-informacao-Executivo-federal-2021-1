library(RSelenium)
library(tidyverse)
library(here)
#'
#' Crawler da página do e-sic da CGU
#' Os dados são baixados de http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx
#' A função `download_cgu_files` acessa a página do e-sic e realiza o download com RSelenium 
#' 
#' PARÂMETROS:
#' . ano: inteiro entre 2015 e 2021
#' . formato: "XML" ou "CSV" (use o xml!)
#' . dest_file: onde vc quer salvar o arquivo?
#' . versao_do_chrome: informe para o RSelenium a versão do Google Chrome (use `binman::list_versions("chromedriver")$win32[5]`)
#' 
#' 
#' 
download_cgu_files <- function(ano,
                               formato,
                               dest_file,
                               versao_do_chrome) {
  
  # dest.file ----
  eCaps <- list(
    chromeOptions = list(
      prefs = list(
        # entra nas opções do Chrome e define pasta de destino para download (dest.file)
        "profile.default_content_settings.popups" = 0L,
        "download.prompt_for_download" = FALSE,
        "download.default_directory" = dest_file
      )
    )
  )
  
  # open web browser ----
  # Importante: faça um teste da versão do chrome
  driver <- rsDriver(
    browser = c("chrome"),
    chromever = versao_do_chrome,  
    port = sample.int(9999, 1),
    extraCapabilities = eCaps
  )
  
  remDr <- driver[["client"]]
  
  # open website ----
  remDr$navigate("http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx")
  Sys.sleep(1)
  
  # ano ----
  ano_vec <- 2:8
  names(ano_vec) <- 2015:2021
  xpath_ano <- sprintf('//*[@id="ctl00_PlaceHolderMain_cmbAno"]/option[%s]', ano_vec[ano])
  
  seleciona_ano <- remDr$findElement(using = 'xpath', xpath_ano)
  seleciona_ano$clickElement()
  Sys.sleep(1)
  
  # format ----
  fmt_vec <- 2:3
  names(fmt_vec) <- c("CSV", "XML")
  xpath_fmt <- sprintf('//*[@id="ctl00_PlaceHolderMain_cmbFormato"]/option[%s]', fmt_vec[formato])
  
  seleciona_formato <- remDr$findElement(using = 'xpath', xpath_fmt)
  seleciona_formato$clickElement()
  Sys.sleep(1)
  
  # aciona download ----
  botao_download <- remDr$findElement(using = 'xpath', '//*[@id="ctl00_PlaceHolderMain_btnDownload"]')
  botao_download$clickElement()

  
}