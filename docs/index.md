Negativas de acesso a informação no governo Federal
================

  - [Relatório](#relatório)
  - [Base de dados](#base-de-dados)
      - [Código](#código)

## Relatório

  - Pedidos por tipo de resposta do órgão (decisão) [CLIQUE
    AQUI](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/1-pedidos-decisoes.html)

  - Pedidos por órgão:
    
      - Acesso Negado [CLIQUE
        AQUI](https://transparencia-brasil.github.io/negativas-acesso-informacao-Executivo-federal-2021-1/2-pedidos-orgaos-acesso-negado.html)

## Base de dados

  - Site do e-SIC/CGU - [clique
    aqui](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx)
  - Dicionário de variáveis - [clique
    aqui](http://www.consultaesic.cgu.gov.br/arquivosRelatorios/PedidosRespostas/Dicionario-Dados-Exportacao.txt)

#### Download da base bruta

  - Os dados brutos estão disponíveis ano a ano no site do e-sic da
    Controladoria Geral da União. Para baixar manualmente [acesse o site
    do
    esic](http://www.consultaesic.cgu.gov.br/busca/_layouts/15/DownloadPedidos/DownloadDados.aspx),
    selecione ano e formato (trabalhamos com XML) e clique em download.

##### Arquivos:

| Arquivo                     | Tamanho (mb) | Data do download    |
| :-------------------------- | :----------: | :------------------ |
| Arquivos\_xml\_2015.zip     |     111      | 2021-09-01 12:18:12 |
| Arquivos\_xml\_2016.zip     |     117      | 2021-09-01 12:15:34 |
| Arquivos\_xml\_2017.zip     |     122      | 2021-09-01 12:15:50 |
| Arquivos\_xml\_2018.zip     |     125      | 2021-09-01 12:16:08 |
| Arquivos\_xml\_2019.zip     |     131      | 2021-09-01 12:17:50 |
| Arquivos\_xml\_2020.zip     |     147      | 2021-09-01 12:16:44 |
| Arquivos\_xml\_2021.zip     |     109      | 2021-09-01 12:17:02 |
| old/Arquivos\_xml\_2015.zip |     110      | 2021-07-27 21:25:45 |
| old/Arquivos\_xml\_2016.zip |     116      | 2021-07-27 21:26:03 |
| old/Arquivos\_xml\_2017.zip |     121      | 2021-07-27 21:26:23 |
| old/Arquivos\_xml\_2018.zip |     124      | 2021-07-27 21:26:41 |
| old/Arquivos\_xml\_2019.zip |     129      | 2021-07-27 21:27:00 |
| old/Arquivos\_xml\_2020.zip |     146      | 2021-07-27 21:29:33 |
| old/Arquivos\_xml\_2021.zip |     102      | 2021-07-27 21:27:39 |

#### Download da base pré-processada

##### RDS

  - **PEDIDOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/1TKnHS2YLZW6BC9ubKqvvoTG9Dg1vVyOO/view?usp=sharing))
  - **RECURSOS** - formato RDS ([link para
    download](https://drive.google.com/file/d/17Kh-jtamT-Q-nBZExwHXQjj3L1kDgmZJ/view?usp=sharing))

##### CSV

  - **PEDIDOS** - formato CSV ([link para
    download](https://drive.google.com/file/d/1R8_M5AVYJfS_8jYFP9NVuVfFtJQrbtlb/view?usp=sharing))
  - **RECURSOS** - formato CSV ([link para
    download](https://drive.google.com/file/d/1ZyMi4AFHq32WayrXPc0wrsgMcv3dG7tp/view?usp=sharing))

##### Preview: pedidos

    #> Rows: 598.461
    #> Columns: 25
    #> $ id_ano_base              [3m[38;5;246m<chr>[39m[23m "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2~
    #> $ id_pedido                [3m[38;5;246m<chr>[39m[23m "1887837", "1887842", "1887846", "1887851", "1887855", "1887858", "1887862", "1887869", "1887876", "1887882", "1887894", "1887900", "1887902", "188~
    #> $ protocolo_pedido         [3m[38;5;246m<chr>[39m[23m "23480010257201512", "23480010258201559", "23480010259201501", "23480010260201528", "23480010261201572", "23480010262201517", "23480010263201561", ~
    #> $ esfera                   [3m[38;5;246m<chr>[39m[23m "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Federal", "Fed~
    #> $ orgaodestinatario        [3m[38;5;246m<chr>[39m[23m "UFPel – Fundação Universidade Federal de Pelotas", "UFRGS – Universidade Federal do Rio Grande do Sul", "IFPI – Instituto Federal de Educação, Ciê~
    #> $ situacao                 [3m[38;5;246m<chr>[39m[23m "Concluída", "Concluída", "Concluída", "Concluída", "Concluída", "Concluída", "Concluída", "Concluída", "Concluída", "Concluída", "Concluída", "Con~
    #> $ data_registro            [3m[38;5;246m<date>[39m[23m 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 20~
    #> $ resumo_solicitacao       [3m[38;5;246m<chr>[39m[23m "Aproveitamento", "Aproveitamento", "Aproveitamento", "Aproveitamento", "Aproveitamento", "Aproveitamento", "Aproveitamento", "Aproveitamento", "Ap~
    #> $ detalhamento_solicitacao [3m[38;5;246m<chr>[39m[23m "Prezados,  Gostaria de solicitar informações sobre a existência de vagas para aproveitamento na UFPEL. Busco informações sobre vagas referentes ao~
    #> $ prazo_atendimento        [3m[38;5;246m<chr>[39m[23m "21/07/2015", "21/07/2015", "21/07/2015", "21/07/2015", "21/07/2015", "21/07/2015", "21/07/2015", "21/07/2015", "22/07/2015", "21/07/2015", "21/07/~
    #> $ foi_prorrogado           [3m[38;5;246m<chr>[39m[23m "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", ~
    #> $ foi_reencaminhado        [3m[38;5;246m<chr>[39m[23m "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Sim", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", "Não", ~
    #> $ forma_resposta           [3m[38;5;246m<chr>[39m[23m "Pelo sistema (com avisos por email)", "Pelo sistema (com avisos por email)", "Pelo sistema (com avisos por email)", "Pelo sistema (com avisos por ~
    #> $ origem_solicitacao       [3m[38;5;246m<chr>[39m[23m "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "In~
    #> $ id_solicitante           [3m[38;5;246m<chr>[39m[23m "2564814", "2564814", "2564814", "2564814", "2564814", "2564814", "2564814", "2564814", "2564814", "2565604", "2564814", "2564814", "2564814", "256~
    #> $ assunto_pedido           [3m[38;5;246m<chr>[39m[23m "Conduta Docente", "Outros em Trabalho", "Conduta Docente", "Educação Superior", "Educação Superior", "Conduta Docente", "Emprego", "Educação Super~
    #> $ data_resposta            [3m[38;5;246m<date>[39m[23m 2015-10-01, 2015-07-01, 2016-11-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 2015-07-01, 20~
    #> $ resposta                 [3m[38;5;246m<chr>[39m[23m "Boa tarde, Em primeiro lugar, pedimos desculpas pelo atraso no envio da resposta a seu questionamento, justificado pela ocorrência da greve dos se~
    #> $ decisao                  [3m[38;5;246m<chr>[39m[23m "Acesso Concedido", "Acesso Concedido", "Acesso Concedido", "Acesso Concedido", "Acesso Concedido", "Acesso Concedido", "Acesso Concedido", "Acesso~
    #> $ especificacao_decisao    [3m[38;5;246m<chr>[39m[23m "Resposta solicitada inserida no Fala.Br", "Resposta solicitada inserida no Fala.Br", "Resposta solicitada inserida no Fala.Br", "Informações envia~
    #> $ sub_assunto_pedido       [3m[38;5;246m<chr>[39m[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
    #> $ ts_registro              [3m[38;5;246m<chr>[39m[23m "01/07/2015", "01/07/2015", "01/07/2015", "01/07/2015", "01/07/2015", "01/07/2015", "01/07/2015", "01/07/2015", "01/07/2015", "01/07/2015", "01/07/~
    #> $ ts_resposta              [3m[38;5;246m<chr>[39m[23m "29/10/2015", "02/07/2015", "29/11/2016", "01/07/2015", "08/07/2015", "01/07/2015", "03/07/2015", "27/07/2015", "06/07/2015", "21/07/2015", "16/07/~
    #> $ governo_que_respondeu    [3m[38;5;246m<fct>[39m[23m Dilma II, Dilma II, Temer, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, ~
    #> $ governo_que_registrou    [3m[38;5;246m<fct>[39m[23m Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma I~

##### Preview: recursos

    #> Rows: 75.453
    #> Columns: 21
    #> $ id_ano_base           [3m[38;5;246m<chr>[39m[23m "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015", "_2015~
    #> $ id_recurso            [3m[38;5;246m<chr>[39m[23m "1650", "1655", "1662", "1666", "1669", "1673", "1677", "1679", "1682", "1687", "1693", "1697", "1703", "1707", "1709", "1716", "1719", "1721", "1723"~
    #> $ desc_recurso          [3m[38;5;246m<chr>[39m[23m "Prezados, Juliana Bastos Neves, brasileira, vem, com fulcro no art. 21, Decreto nº 7.724/2012, interpor o presente recurso, nos termos que se seguem.~
    #> $ id_pedido             [3m[38;5;246m<chr>[39m[23m "2137339", "2105082", "2178667", "2160962", "2178733", "2156293", "2164819", "2155032", "2081639", "2114915", "2120056", "2130642", "2104017", "208604~
    #> $ id_solicitante        [3m[38;5;246m<chr>[39m[23m "2569756", "13927", "2249316", "2140825", "2603293", "2413842", "2606078", "2413842", "247857", "2413842", "2305846", "2613945", "668379", "668379", "~
    #> $ protocolo_pedido      [3m[38;5;246m<chr>[39m[23m "09200000812201568", "23480016577201578", "99908000770201591", "99920000311201549", "23480018519201589", "09200000855201543", "02680002544201514", "09~
    #> $ orgaodestinatario     [3m[38;5;246m<chr>[39m[23m "MRE – Ministério das Relações Exteriores", "CGU/OGU - Ouvidoria-Geral da União", "ELETROBRÁS – Centrais Elétricas Brasileiras S.A.", "Autoridade Port~
    #> $ instancia             [3m[38;5;246m<chr>[39m[23m "Primeira Instância", "CGU", "Primeira Instância", "Primeira Instância", "Primeira Instância", "Primeira Instância", "Primeira Instância", "Segunda In~
    #> $ situacao              [3m[38;5;246m<chr>[39m[23m "Respondido", "Respondido", "Respondido", "Respondido", "Respondido", "Respondido", "Respondido", "Respondido", "Respondido", "Respondido", "Respondid~
    #> $ data_registro         [3m[38;5;246m<date>[39m[23m 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-~
    #> $ prazo_atendimento     [3m[38;5;246m<chr>[39m[23m "28/12/2015", "28/12/2015", "28/12/2015", "28/12/2015", "28/12/2015", "28/12/2015", "28/12/2015", "28/12/2015", "28/12/2015", "28/12/2015", "28/12/201~
    #> $ origem_solicitacao    [3m[38;5;246m<chr>[39m[23m "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Internet", "Inter~
    #> $ tipo_recurso          [3m[38;5;246m<chr>[39m[23m "Informação recebida não corresponde à solicitada", "Informação recebida não corresponde à solicitada", "Informação incompleta", "Informação recebida ~
    #> $ data_resposta         [3m[38;5;246m<date>[39m[23m 2015-12-01, 2016-02-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2015-12-01, 2016-02-01, 2015-12-01, 2015-12-01, 2015-12-01, 2017-~
    #> $ resposta_recurso      [3m[38;5;246m<chr>[39m[23m "Prezada Senhora,  Com referência ao recurso interposto, relacionado ao pedido de acesso à informação NUP nº 09200000812201568, e de acordo com o §1º,~
    #> $ tipo_resposta         [3m[38;5;246m<chr>[39m[23m "Indeferido", "Não conhecimento", "Deferido", "Indeferido", "Deferido", "Indeferido", "Deferido", "Indeferido", "Não conhecimento", "Parcialmente defe~
    #> $ id_recurso_precedente [3m[38;5;246m<chr>[39m[23m NA, "124552", NA, NA, NA, NA, NA, "124247", "124487", "124245", "124612", NA, "124586", "124229", "124228", "124239", NA, "124362", "124491", "123634"~
    #> $ ts_registro           [3m[38;5;246m<chr>[39m[23m "21/12/2015", "21/12/2015", "21/12/2015", "21/12/2015", "21/12/2015", "21/12/2015", "21/12/2015", "21/12/2015", "21/12/2015", "21/12/2015", "21/12/201~
    #> $ ts_resposta           [3m[38;5;246m<chr>[39m[23m "28/12/2015", "10/02/2016", "23/12/2015", "28/12/2015", "21/12/2015", "23/12/2015", "22/12/2015", "29/12/2015", "26/02/2016", "23/12/2015", "24/12/201~
    #> $ governo_que_respondeu [3m[38;5;246m<fct>[39m[23m Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Temer, Dilma II, Dilma II, Dil~
    #> $ governo_que_registrou [3m[38;5;246m<fct>[39m[23m Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, Dilma II, ~

### Código

  - [`1-download-funcao-crawler-esic.R`](%60src/1-download-funcao-crawler-esic.R%60)
  - [`2-download-crawler-exec.R`](%60src/2-download-crawler-exec.R%60)
  - [`3-pedidos-cgu-pre-processamento.R`](%60src/3-pedidos-cgu-pre-processamento.R%60)
  - [`4-solicitantes-cgu-pre-processamento.R`](%60src/4-solicitantes-cgu-pre-processamento.R%60)
  - [`5-pedidos-cgu-nlp.R`](%60src/5-pedidos-cgu-nlp.R%60)
  - [`6-termos-controversos.R`](%60src/6-termos-controversos.R%60)
  - [`download_dados_cgu.ipynb`](%60src/download_dados_cgu.ipynb%60)
