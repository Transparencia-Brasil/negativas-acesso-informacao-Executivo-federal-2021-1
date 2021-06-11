Negativas de acesso a informação no governo Federal
================

-   [Relatório](#relatório)
-   [Base de dados](#base-de-dados)
    -   [Código](#código)

## Relatório

-   Relatório com visualizações e código fonte da análise dos dados -
    **[CLIQUE
    AQUI](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/negativas-de-acesso-a-informacao.html)**

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

| Arquivo                  | Tamanho (mb) | Data do download    |
|:-------------------------|:------------:|:--------------------|
| Arquivos\_xml\_2015.zip  |    107,4     | 2021-06-10 14:28:02 |
| Arquivos\_xml\_2016-.zip |    113,7     | 2021-06-10 14:31:10 |
| Arquivos\_xml\_2016.zip  |    113,7     | 2021-06-10 23:25:03 |
| Arquivos\_xml\_2017.zip  |    118,7     | 2021-06-10 14:31:19 |
| Arquivos\_xml\_2018.zip  |    121,4     | 2021-06-10 14:31:27 |
| Arquivos\_xml\_2019.zip  |    126,9     | 2021-06-10 14:31:31 |
| Arquivos\_xml\_2020.zip  |    143,5     | 2021-06-10 14:31:35 |
| Arquivos\_xml\_2021.zip  |     90,1     | 2021-06-10 14:31:39 |

#### Download da base pré-processada

##### RDS

-   **PEDIDOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/1TKnHS2YLZW6BC9ubKqvvoTG9Dg1vVyOO/view?usp=sharing))
-   **RECURSOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/17Kh-jtamT-Q-nBZExwHXQjj3L1kDgmZJ/view?usp=sharing))

##### CSV

-   **PEDIDOS** - formato CSV ([link para
    download](https://drive.google.com/file/d/1R8_M5AVYJfS_8jYFP9NVuVfFtJQrbtlb/view?usp=sharing))
-   **RECURSOS** - formato CSV ([link para
    download](https://drive.google.com/file/d/1ZyMi4AFHq32WayrXPc0wrsgMcv3dG7tp/view?usp=sharing))

##### Preview: pedidos

    #> Rows: 581,036
    #> Columns: 23
    #> $ id_ano_base              <chr> "_2021", "_2021", "_2021", "_2021", "_2021", ~
    #> $ id_pedido                <chr> "2793736", "2793760", "2793766", "2793772", "~
    #> $ protocolo_pedido         <chr> "23658000001202168", "18830000001202180", "23~
    #> $ esfera                   <chr> "Federal", "Federal", "Federal", "Federal", "~
    #> $ orgaodestinatario        <chr> "EBSERH - HUAB-UFRN - Hospital Universitário ~
    #> $ situacao                 <chr> "Concluída", "Concluída", "Concluída", "Concl~
    #> $ data_registro            <date> 2021-01-01, 2021-01-01, 2021-01-01, 2021-01-~
    #> $ resumo_solicitacao       <chr> "Transparência da seleção ", "copia de docume~
    #> $ detalhamento_solicitacao <chr> "Solicito esclarecimentos do processo de sele~
    #> $ prazo_atendimento        <chr> "25/01/2021", "25/01/2021", "25/01/2021", "25~
    #> $ foi_prorrogado           <chr> "Sim", "Não", "Não", "Não", "Não", "Não", "Nã~
    #> $ foi_reencaminhado        <chr> "Sim", "Não", "Não", "Não", "Não", "Não", "Nã~
    #> $ forma_resposta           <chr> "Pelo sistema (com avisos por email)", "Pelo ~
    #> $ origem_solicitacao       <chr> "Internet", "Internet", "Internet", "Internet~
    #> $ id_solicitante           <chr> "0", "3811063", "0", "3032692", "1311219", "1~
    #> $ assunto_pedido           <chr> "Outros em Administração", "Outros em Previdê~
    #> $ sub_assunto_pedido       <chr> "Outros", NA, NA, NA, NA, NA, NA, NA, NA, NA,~
    #> $ data_resposta            <date> 2021-01-01, 2021-01-01, 2021-01-01, 2021-01-~
    #> $ resposta                 <chr> "Senhor (a) cidadão (a)    Em atenção ao pedi~
    #> $ decisao                  <chr> "Acesso Concedido", "Acesso Concedido", "Aces~
    #> $ especificacao_decisao    <chr> "Resposta solicitada inserida no Fala.Br", "R~
    #> $ governo_que_respondeu    <fct> Bolsonaro, Bolsonaro, Bolsonaro, Bolsonaro, B~
    #> $ governo_que_registrou    <fct> Bolsonaro, Bolsonaro, Bolsonaro, Bolsonaro, B~

##### Preview: recursos

    #> Rows: 72,580
    #> Columns: 19
    #> $ id_ano_base           <chr> "_2021", "_2021", "_2021", "_2021", "_2021", "_2~
    #> $ id_recurso            <chr> "129788", "129836", "129869", "129888", "129898"~
    #> $ desc_recurso          <chr> "Se a pergunta não deve ser respondida pelo órgã~
    #> $ id_pedido             <chr> "2799350", "2800034", "2804922", "2796830", "279~
    #> $ id_solicitante        <chr> "0", "1296409", "3941868", "3911027", "3923292",~
    #> $ protocolo_pedido      <chr> "71003000764202156", "48003000037202177", "21210~
    #> $ orgaodestinatario     <chr> "MCIDADANIA - Ministério da Cidadania (Desenvolv~
    #> $ instancia             <chr> "Primeira Instância", "Primeira Instância", "Pri~
    #> $ situacao              <chr> "Respondido", "Respondido", "Respondido", "Respo~
    #> $ data_registro         <date> 2021-01-01, 2021-01-01, 2021-01-01, 2021-01-01,~
    #> $ prazo_atendimento     <chr> "11/01/2021", "11/01/2021", "12/01/2021", "12/01~
    #> $ origem_solicitacao    <chr> "Internet", "Internet", "Internet", "Internet", ~
    #> $ tipo_recurso          <chr> "Informação recebida não corresponde à solicitad~
    #> $ data_resposta         <date> 2021-01-01, 2021-01-01, 2021-01-01, 2021-01-01,~
    #> $ resposta_recurso      <chr> "Prezado (a) senhor (a),    Em atenção ao recurs~
    #> $ tipo_resposta         <chr> "Não conhecimento", "Não conhecimento", "Não con~
    #> $ id_recurso_precedente <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ governo_que_respondeu <fct> Bolsonaro, Bolsonaro, Bolsonaro, Bolsonaro, Bols~
    #> $ governo_que_registrou <fct> Bolsonaro, Bolsonaro, Bolsonaro, Bolsonaro, Bols~

### Código

-   [`1-download-funcao-crawler-esic`](src/1-pedidos-cgu-funcao-crawler-esic.R):
    função para acessar o site do esic e baixar base de dados de pedidos
    de informação (usa RSelenium)
-   [`2-download-crawler-exec`](src/2-pedidos-cgu-crawler-exec.R): baixa
    todas as bases de dados de pedidos de informação em um loop
-   [`3-pedidos-cgu-crawler-e-pre-processamento.R`](src/3-pedidos-cgu-crawler-e-pre-processamento.R):
    código com pré-processamento da base (converte o XML em rds)
