Negativas de acesso a informação no governo Federal
================

-   [Relatório](#relatório)
-   [Base de dados](#base-de-dados)
    -   [Código](#código)

## Relatório

-   Relatório com visualizações e código fonte da análise dos dados -
    **[CLIQUE
    AQUI](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/negativas-de-acesso-a-informacao.html)**

-   Versão anual (em andamento): **[CLIQUE
    AQUI](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/negativas-de-acesso-a-informacao-2.html)**

## Base de dados

-   Site do e-SIC/CGU - [clique
    aqui](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx)
-   Dicionário de variáveis - [clique
    aqui](http://www.consultaesic.cgu.gov.br/arquivosRelatorios/PedidosRespostas/Dicionario-Dados-Exportacao.txt)

#### Download da base bruta

-   Os dados brutos estão disponíveis ano a ano no site do e-sic da
    Controladoria Geral da União. Para baixar manualmente [acesse o site
    do
    esic](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx),
    selecione ano e formato (trabalhamos com XML) e clique em download.

##### Arquivos:

| Arquivo                 | Tamanho (mb) | Data do download    |
|:------------------------|:------------:|:--------------------|
| Arquivos\_xml\_2015.zip |    109,6     | 2021-07-27 21:25:45 |
| Arquivos\_xml\_2016.zip |    115,9     | 2021-07-27 21:26:03 |
| Arquivos\_xml\_2017.zip |    120,8     | 2021-07-27 21:26:23 |
| Arquivos\_xml\_2018.zip |    123,5     | 2021-07-27 21:26:41 |
| Arquivos\_xml\_2019.zip |    129,1     | 2021-07-27 21:27:00 |
| Arquivos\_xml\_2020.zip |    145,7     | 2021-07-27 21:29:33 |
| Arquivos\_xml\_2021.zip |    101,6     | 2021-07-27 21:27:39 |

#### Download da base pré-processada

##### RDS

-   **PEDIDOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/18O1QHpbAEuQjmYzFe_x9Izore3t9mf2A/view?usp=sharing))
-   **RECURSOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/1lt8cifXvJo4yTd6VNhlWLp4WDKcIlgAQ/view?usp=sharing))

##### CSV

-   **PEDIDOS** - formato CSV ([link para
    download](https://drive.google.com/file/d/1Vrq4UQcO325V3dWXjG36LTvwCNsGFI66/view?usp=sharing))
-   **RECURSOS** - formato CSV ([link para
    download](https://drive.google.com/file/d/1TZZgXnh12FiYlimxhdFzUWE7dQ-CtpPi/view?usp=sharing))

##### Preview: pedidos

    #> Rows: 592,144
    #> Columns: 25
    #> $ id_ano_base              <chr> "_2015", "_2015", "_2015", "_2015", "_2015", ~
    #> $ id_pedido                <chr> "1887837", "1887842", "1887846", "1887851", "~
    #> $ protocolo_pedido         <chr> "23480010257201512", "23480010258201559", "23~
    #> $ esfera                   <chr> "Federal", "Federal", "Federal", "Federal", "~
    #> $ orgaodestinatario        <chr> "UFPel – Fundação Universidade Federal de Pel~
    #> $ situacao                 <chr> "Concluída", "Concluída", "Concluída", "Concl~
    #> $ data_registro            <date> 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-~
    #> $ resumo_solicitacao       <chr> "Aproveitamento", "Aproveitamento", "Aproveit~
    #> $ detalhamento_solicitacao <chr> "Prezados,  Gostaria de solicitar informações~
    #> $ prazo_atendimento        <chr> "21/07/2015", "21/07/2015", "21/07/2015", "21~
    #> $ foi_prorrogado           <chr> "Não", "Não", "Não", "Não", "Não", "Não", "Nã~
    #> $ foi_reencaminhado        <chr> "Não", "Não", "Não", "Não", "Não", "Não", "Nã~
    #> $ forma_resposta           <chr> "Pelo sistema (com avisos por email)", "Pelo ~
    #> $ origem_solicitacao       <chr> "Internet", "Internet", "Internet", "Internet~
    #> $ id_solicitante           <chr> "2564814", "2564814", "2564814", "2564814", "~
    #> $ assunto_pedido           <chr> "Conduta Docente", "Outros em Trabalho", "Con~
    #> $ data_resposta            <date> 2015-10-01, 2015-07-01, 2016-11-01, 2015-07-~
    #> $ resposta                 <chr> "Boa tarde, Em primeiro lugar, pedimos descul~
    #> $ decisao                  <chr> "Acesso Concedido", "Acesso Concedido", "Aces~
    #> $ especificacao_decisao    <chr> "Resposta solicitada inserida no Fala.Br", "R~
    #> $ sub_assunto_pedido       <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N~
    #> $ ts_registro              <chr> "01/07/2015", "01/07/2015", "01/07/2015", "01~
    #> $ ts_resposta              <chr> "29/10/2015", "02/07/2015", "29/11/2016", "01~
    #> $ governo_que_respondeu    <fct> Dilma II, Dilma II, Temer, Dilma II, Dilma II~
    #> $ governo_que_registrou    <fct> Dilma II, Dilma II, Dilma II, Dilma II, Dilma~

##### Preview: recursos

    #> Rows: 74,280
    #> Columns: 21
    #> $ id_ano_base           <chr> "_2015", "_2015", "_2015", "_2015", "_2015", "_2~
    #> $ id_recurso            <chr> "1650", "1655", "1662", "1666", "1669", "1673", ~
    #> $ desc_recurso          <chr> "Prezados, Juliana Bastos Neves, brasileira, vem~
    #> $ id_pedido             <chr> "2137339", "2105082", "2178667", "2160962", "217~
    #> $ id_solicitante        <chr> "2569756", "13927", "2249316", "2140825", "26032~
    #> $ protocolo_pedido      <chr> "09200000812201568", "23480016577201578", "99908~
    #> $ orgaodestinatario     <chr> "MRE – Ministério das Relações Exteriores", "CGU~
    #> $ instancia             <chr> "Primeira Instância", "CGU", "Primeira Instância~
    #> $ situacao              <chr> "Respondido", "Respondido", "Respondido", "Respo~
    #> $ data_registro         <date> 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01,~
    #> $ prazo_atendimento     <chr> "28/12/2015", "28/12/2015", "28/12/2015", "28/12~
    #> $ origem_solicitacao    <chr> "Internet", "Internet", "Internet", "Internet", ~
    #> $ tipo_recurso          <chr> "Informação recebida não corresponde à solicitad~
    #> $ data_resposta         <date> 2015-12-01, 2016-02-01, 2015-12-01, 2015-12-01,~
    #> $ resposta_recurso      <chr> "Prezada Senhora,  Com referência ao recurso int~
    #> $ tipo_resposta         <chr> "Indeferido", "Não conhecimento", "Deferido", "I~
    #> $ id_recurso_precedente <chr> NA, "124552", NA, NA, NA, NA, NA, "124247", "124~
    #> $ ts_registro           <chr> "21/12/2015", "21/12/2015", "21/12/2015", "21/12~
    #> $ ts_resposta           <chr> "28/12/2015", "10/02/2016", "23/12/2015", "28/12~
    #> $ governo_que_respondeu <fct> Dilma II, Dilma II, Dilma II, Dilma II, Dilma II~
    #> $ governo_que_registrou <fct> Dilma II, Dilma II, Dilma II, Dilma II, Dilma II~

### Código

-   [`1-download-funcao-crawler-esic`](src/1-pedidos-cgu-funcao-crawler-esic.R):
    função para acessar o site do esic e baixar base de dados de pedidos
    de informação (usa RSelenium)
-   [`2-download-crawler-exec`](src/2-pedidos-cgu-crawler-exec.R): baixa
    todas as bases de dados de pedidos de informação em um loop
-   [`3-pedidos-cgu-crawler-e-pre-processamento.R`](src/3-pedidos-cgu-crawler-e-pre-processamento.R):
    código com pré-processamento da base (converte o XML em rds)
