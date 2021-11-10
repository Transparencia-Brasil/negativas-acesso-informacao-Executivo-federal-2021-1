Negativas de acesso a informação no governo Federal
================

-   [Relatório](#relatório)
-   [Base de dados](#base-de-dados)

## Relatório

1.  **Pedidos de acesso a informação via LAI no FalaBr**

    -   [Base
        anonimizada](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/1-pedidos-decisoes.html)
    -   [Base completa (painel
        CGU)](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/1-b-pedidos-decisoes-painel.html)

2.  **Acesso negado nos órgãos**

    -   [Base anonimizada -
        geral](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/2-pedidos-orgaos-acesso-negado.html)
    -   [Base completa (painel CGU) - órgão a
        órgão](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/3-acesso-negado-para-cada-orgao.html)
    -   [Base completa (painel CGU) -
        geral](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/2-b-pedidos-orgaos-acesso-negado.html)

3.  **Uso da LGPD nas respostas aos pedidos de acesso a informação via
    LAI**

    -   [Base
        anonimizada](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/4-controversos-lgpd.html)

4.  **Recursos**

    -   [Base
        anonimizada](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/5-recursos.html)

## Base de dados

-   Base de dados da CGU com pedidos e respostas [clique
    aqui](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx)
    -   Esses dados vão de 2015 até 2021 e possuem os campos de texto
        dos pedidos, das resposta e dos recursos completos.
-   Base de dados do [painel da
    cgu](http://paineis.cgu.gov.br/lai/index.htm), disponível para
    download [neste
    link](https://falabr.cgu.gov.br/publico/DownloadDados/DownloadDadosLai.aspx)
    -   Esses dados vão de 2012 até 2021 mas não possuem os campos de
        texto dos pedidos, das respostas e dos recursos.
-   Dicionário de variáveis - [clique
    aqui](http://www.consultaesic.cgu.gov.br/arquivosRelatorios/PedidosRespostas/Dicionario-Dados-Exportacao.txt)

[**Comparativo entre as bases disponíveis no
FalaBr**](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/6-comparativo-entre-bases-do-falabr.html)

#### Download da base bruta

-   Os dados brutos estão disponíveis ano a ano no site do e-sic da
    Controladoria Geral da União. Para baixar manualmente [acesse o site
    do
    esic](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx),
    selecione ano e formato (trabalhamos com XML) e clique em download.

##### Arquivos:

|   Tipo   | Ano  |              Arquivo              | Tamanho (mb) |
|:--------:|:----:|:---------------------------------:|-------------:|
| Pedidos  | 2015 | 20211025\_Pedidos\_xml\_2015.xml  |        277,0 |
| Pedidos  | 2016 | 20211025\_Pedidos\_xml\_2016.xml  |        324,2 |
| Pedidos  | 2017 | 20211025\_Pedidos\_xml\_2017.xml  |        346,3 |
| Pedidos  | 2018 | 20211025\_Pedidos\_xml\_2018.xml  |        370,9 |
| Pedidos  | 2019 | 20211025\_Pedidos\_xml\_2019.xml  |        402,7 |
| Pedidos  | 2020 | 20211025\_Pedidos\_xml\_2020.xml  |        532,2 |
| Pedidos  | 2021 | 20211025\_Pedidos\_xml\_2021.xml  |        333,7 |
| Recursos | 2015 | 20211025\_Recursos\_xml\_2015.xml |         38,8 |
| Recursos | 2016 | 20211025\_Recursos\_xml\_2016.xml |         46,5 |
| Recursos | 2017 | 20211025\_Recursos\_xml\_2017.xml |         54,8 |
| Recursos | 2018 | 20211025\_Recursos\_xml\_2018.xml |         54,1 |
| Recursos | 2019 | 20211025\_Recursos\_xml\_2019.xml |         64,6 |
| Recursos | 2020 | 20211025\_Recursos\_xml\_2020.xml |         68,9 |
| Recursos | 2021 | 20211025\_Recursos\_xml\_2021.xml |         42,8 |

#### Download da base pré-processada

Disponibilzamos a base de dados em formatos `csv` e `rds`: [CLIQUE
AQUI](https://drive.google.com/drive/folders/12a0qO8Spxc8IE_Wdlb0fjm88kD6JjVgk)

##### Preview: pedidos

    #> Rows: 608,836
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

    #> Rows: 76,750
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
