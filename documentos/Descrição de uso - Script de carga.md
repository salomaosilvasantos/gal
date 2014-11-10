##Descrição de uso 

###Script de carga de títulos e exemplares

####GAL – Gestão de Aquisição de Livros
---

####Objetivos
Este documento tem como objetivo detalhar a forma de uso do script de carga de dados de títulos e exemplares no banco de dados do GAL.

####Descrição
Apartir de um arquivo com extensão xls que contenha as informações dos exemplares é possível atualizar o banco de dados, inserindo novos títulos, exemplares ou adicionar exemplares em títulos já cadastrados.

####Pré-condições
O arquivo deve seguir a formação como segue o modelo.

Modelo: https://drive.google.com/file/d/0B1kTNvMk2fMnWXJmcjBNOU4yQ0U/view?usp=sharing

####Passos de ação
1. Informe o caminho do arquivo com extensão xls.

2. Os títulos que apresentam dados válidos e ainda não estão cadastrados no banco de dados serão adicionados. Os casos de títulos com dados inválidos que já constam no banco de dados não serão cadastrados, no arquivo de log são indicados como "Exemplar não cadastrado"

3. Ao termino da execução é informado o fim da operação.

####Pós-Condições
1. O banco de dados estará carregado com novos dados, caso existam novos títulos ou exemplares descritos no arquivo de entrada.
2. Um arquivo de texto será gerado informando as ações executadas para cada exemplar contido no arquivo de entrada. O arquivo será nomeado como "log_xx_xx_xxxx" 