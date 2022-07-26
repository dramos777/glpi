# GLPI Project
*O GLPI é um incrível software de gerenciamento de serviços baseado em tecnologias de código aberto. Ele ajuda você a planejar e gerenciar mudanças de TI de maneira fácil, resolver problemas com eficiência, automatizar seus processos de negócios e obter controle sobre sua infraestrutura de TI.
(https://glpi-project.org)*

### Resumo

Personalização dos containers docker nginx:alpine e php:fpm-alpine com configurações e requisitos básicos necessários para o deploy da GLPI-v10.x com banco de dados mariadb/mysql.

### Dependências

- GNU Linux com Docker instalado

### Forma de usar

Clone do repositório e deploy da app:

```
git clone https://github.com/dramos777/glpi.git
cd glpi
docker stack deploy -c docker-compose.yml glpi

```
OBS.: O diretório glpi-project contém o conteúdo do projeto GLPI baixado no site oficial. Altere o usuario/grupo dono do diretório para o usuário/grupo do container php:fpm-alpine (www-data:www-data uid=82 gui=82). Para testar os containers com outras versões do GLPI substitua o conteúdo desta pasta com os arquivos da versão do GLPI desejada.

### Testado em:
- Debian GNU/Linux 11 com Docker 20.10.5+dfsg1 e cluster swarm iniciado


### Histórico

v1.0 26/07/2022, Emanuel Dramos:
- Criação do Dockerfile
- Criação do README.md
- Build da imagem e push para o Dockerhub
- Push do projeto para o github
- Deploy da aplicação e teste de conexão com o banco de dados


### Autor e mantenedor
Emanuel Dramos
- **Github:** https://github.com/dramos777

