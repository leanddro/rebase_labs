# Rebase Labs

### Tópicos

:diamond_shape_with_a_dot_inside: [Descrição do projeto](#descrição-do-projeto)

:diamond_shape_with_a_dot_inside: [Modelo ER](#modelo-er)

:diamond_shape_with_a_dot_inside: [Funcionalidades](#funcionalidades)

:diamond_shape_with_a_dot_inside: [Como rodar a aplicação](#como-rodar-a-aplicação)

## Descrição do projeto

<p align="justify">
  Sistema feito com base no aprendizado adquirido, o laboratório ofertado pela Rebase. O sistema consiste na listagem e
  importação de exames laboratoriais utilizando tecnologias como ruby, sinatra, sequel, postgresql, redis, sidekiq, docker, javascript
</p>

## Modelo ER!

![Untitled](https://github.com/leanddro/rebase_labs/assets/75085756/0c7445cc-c8f9-4a18-9264-f92b36180b24)


## Funcionalidades

:white_check_mark: Listar Exames

:white_check_mark: Ver detalhes de Exame

:white_check_mark: Importar csv por linha de comando

:white_check_mark: Importar csv pela web

:white_check_mark: Buscar exame pelo token
## Como rodar a aplicação

No terminal, clone o projeto:

```sh
git clone https://github.com/leanddro/rebase_labs
```

Entre na pasta do projeto:

```sh
cd rebase_labs
```

Der permissão de execução ao arquivo de suporte
```sh
chmod +x bin/dev
chmod +x bin/test
```

Executando os testes

```sh
bin/test
```

Subindo aplicação

```sh
bin/dev
```

Rota principal da aplicação

http://localhost:3000/exams
