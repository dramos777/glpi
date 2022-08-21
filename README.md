# GLPI Project
*O GLPI é um incrível software de gerenciamento de serviços baseado em tecnologias de código aberto. Ele ajuda você a planejar e gerenciar mudanças de TI de maneira fácil, resolver problemas com eficiência, automatizar seus processos de negócios e obter controle sobre sua infraestrutura de TI.
(https://glpi-project.org)*

### Resumo

- Personalização das configurações do nginx para https e redirecionar http.
- Alteração do container php:fpm-alpine com instalação e configuração dos pacotes básicos necessários para o deploy da GLPI-v10.x com banco de dados mariadb/mysql.

### Dependências

- GNU Linux com Docker instalado

### Testado em:
- GNU/Linux Debian 11 com Docker 20.10.5+dfsg1 (swarm)
- GNU/Linux Debian 11 com Docker 20.10.17 (swarm)

### Antes de iniciar

- O diretório *glpi-project* contém o conteúdo do projeto GLPI baixado no site oficial *(https://glpi-project.org)*.
- Para testes utilizando outras versões do GLPI substitua o conteúdo da pasta *glpi-project* com os arquivos da versão do GLPI desejada.
- Altere *seudominio.abc,www.seudominio.abc e www2.seudominio.abc* nos arquivos de configuração.

### Como usar

Caso não tenha o Docker instalado:

```
curl -fsSL https://get.docker.com | bash

```
Inicialização do cluster swarm:

```
docker swarm init

```

Clone do repositório:

```
git clone https://github.com/dramos777/glpi.git
cd glpi

```
Criação do certificado:

```
openssl req -newkey rsa:2048 -nodes -keyout ./certificates/privkey.pem -x509 -days 365 -out ./certificates/fullchain.pem && openssl dhparam -out ./certificates/dhparam.pem 2048

```
Deploy da APP:

```
docker stack deploy -c docker-compose.yml glpi

```

### Histórico

v1.0 26/07/2022, Emanuel Dramos:
- Criação do Dockerfile
- Criação do README.md
- Build da imagem e push para o Dockerhub
- Push do projeto para o github
- Deploy da aplicação e teste de conexão com o banco de dados

v1.1 21/08/2022, Emanuel Dramos:
- Atualização do README.md
- Atualização dos arquivos de configuração do nginx - https
- Atualização do docker-compose
- Deploy da aplicação


### Autor e mantenedor
Emanuel Dramos
- **Github:** https://github.com/dramos777

