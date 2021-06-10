Negativas de acesso a informação no governo Federal
================

## Base de dados

-   Site do e-SIC/CGU - [clique
    aqui](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx)
-   Dicionário de variáveis - [clique
    aqui](http://www.consultaesic.cgu.gov.br/arquivosRelatorios/PedidosRespostas/Dicionario-Dados-Exportacao.txt)

### Download da base bruta

-   Os dados brutos estão disponíveis ano a ano no site do e-sic da
    Controladoria Geral da União. Para baixar manualmente [acesse o site
    do
    esic](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx),
    selecione ano e formato (trabalhamos com XML) e clique em download.

#### Arquivos:

| Arquivo                 | Tamanho (mb) | Data do download    |
|:------------------------|:------------:|:--------------------|
| Arquivos\_xml\_2015.zip |    107,4     | 2021-06-10 14:28:02 |
| Arquivos\_xml\_2016.zip |    113,7     | 2021-06-10 14:31:10 |
| Arquivos\_xml\_2017.zip |    118,7     | 2021-06-10 14:31:19 |
| Arquivos\_xml\_2018.zip |    121,4     | 2021-06-10 14:31:27 |
| Arquivos\_xml\_2019.zip |    126,9     | 2021-06-10 14:31:31 |
| Arquivos\_xml\_2020.zip |    143,5     | 2021-06-10 14:31:35 |
| Arquivos\_xml\_2021.zip |     90,1     | 2021-06-10 14:31:39 |

### Download da base pré-processada

-   **PEDIDOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/1TKnHS2YLZW6BC9ubKqvvoTG9Dg1vVyOO/view?usp=sharing))

-   **RECURSOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/17Kh-jtamT-Q-nBZExwHXQjj3L1kDgmZJ/view?usp=sharing))

-   Preview: pedidos

<!-- -->

    #> Rows: 515,077
    #> Columns: 21
    #> $ ano                     <chr> "2015", "2015", "2015", "2015", "2015", "2015"~
    #> $ idpedido                <chr> "2793736", "2793760", "2793766", "2793772", "2~
    #> $ protocolopedido         <chr> "23658000001202168", "18830000001202180", "235~
    #> $ esfera                  <chr> "Federal", "Federal", "Federal", "Federal", "F~
    #> $ orgaodestinatario       <chr> "EBSERH - HUAB-UFRN - Hospital Universitário A~
    #> $ situacao                <chr> "Concluída", "Concluída", "Concluída", "Conclu~
    #> $ dataregistro            <chr> "01/01/2021", "01/01/2021", "01/01/2021", "01/~
    #> $ resumosolicitacao       <chr> "Transparência da seleção ", "copia de documen~
    #> $ detalhamentosolicitacao <chr> "Solicito esclarecimentos do processo de seleç~
    #> $ prazoatendimento        <chr> "25/01/2021", "25/01/2021", "25/01/2021", "25/~
    #> $ foiprorrogado           <chr> "Sim", "Não", "Não", "Não", "Não", "Não", "Não~
    #> $ foireencaminhado        <chr> "Sim", "Não", "Não", "Não", "Não", "Não", "Não~
    #> $ formaresposta           <chr> "Pelo sistema (com avisos por email)", "Pelo s~
    #> $ origemsolicitacao       <chr> "Internet", "Internet", "Internet", "Internet"~
    #> $ idsolicitante           <chr> "0", "3811063", "0", "3032692", "1311219", "13~
    #> $ assuntopedido           <chr> "Outros em Administração", "Outros em Previdên~
    #> $ subassuntopedido        <chr> "Outros", NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ dataresposta            <chr> "21/01/2021", "04/01/2021", "25/01/2021", "15/~
    #> $ resposta                <chr> "Senhor (a) cidadão (a)    Em atenção ao pedid~
    #> $ decisao                 <chr> "Acesso Concedido", "Acesso Concedido", "Acess~
    #> $ especificacaodecisao    <chr> "Resposta solicitada inserida no Fala.Br", "Re~

-   Preview: recursos

<!-- -->

    #> Rows: 72,580
    #> Columns: 17
    #> $ ano                 <chr> "2015", "2015", "2015", "2015", "2015", "2015", "2~
    #> $ idrecurso           <chr> "129788", "129836", "129869", "129888", "129898", ~
    #> $ descrecurso         <chr> "Se a pergunta não deve ser respondida pelo órgão ~
    #> $ idpedido            <chr> "2799350", "2800034", "2804922", "2796830", "27952~
    #> $ idsolicitante       <chr> "0", "1296409", "3941868", "3911027", "3923292", "~
    #> $ protocolopedido     <chr> "71003000764202156", "48003000037202177", "2121000~
    #> $ orgaodestinatario   <chr> "MCIDADANIA - Ministério da Cidadania (Desenvolvim~
    #> $ instancia           <chr> "Primeira Instância", "Primeira Instância", "Prime~
    #> $ situacao            <chr> "Respondido", "Respondido", "Respondido", "Respond~
    #> $ dataregistro        <chr> "05/01/2021", "06/01/2021", "07/01/2021", "07/01/2~
    #> $ prazoatendimento    <chr> "11/01/2021", "11/01/2021", "12/01/2021", "12/01/2~
    #> $ origemsolicitacao   <chr> "Internet", "Internet", "Internet", "Internet", "I~
    #> $ tiporecurso         <chr> "Informação recebida não corresponde à solicitada"~
    #> $ dataresposta        <chr> "08/01/2021", "06/01/2021", "12/01/2021", "12/01/2~
    #> $ respostarecurso     <chr> "Prezado (a) senhor (a),    Em atenção ao recurso ~
    #> $ tiporesposta        <chr> "Não conhecimento", "Não conhecimento", "Não conhe~
    #> $ idrecursoprecedente <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA~

### Código

-   [`1-download-funcao-crawler-esic`](src/1-pedidos-cgu-funcao-crawler-esic.R):
    função para acessar o site do esic e baixar base de dados de pedidos
    de informação (usa RSelenium)
-   [`2-download-crawler-exec`](src/2-pedidos-cgu-crawler-exec.R): baixa
    todas as bases de dados de pedidos de informação em um loop
-   [`3-pedidos-cgu-crawler-e-pre-processamento.R`](src/3-pedidos-cgu-crawler-e-pre-processamento.R):
    código com pré-processamento da base (converte o XML em rds)
