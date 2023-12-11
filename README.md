<h1 align="center">
<img width="32" height="32" src="https://img.icons8.com/color/48/flutter.png" alt="flutter"/> GameStellar
</h1>

>[!NOTE]
> Este aplicativo está sendo desenvolvido para estudo e exemplificação de desenvolvimento com Flutter/Dart na matéria PAC (Projeto de Apredizado Colaborativo). O mesmo não será utilizado para fins comerciais.

A idéia do aplicativo surgiu em torno de centralizar todas as informações relacionadas ao mundo de jogos eletrônicos, tais como lançamentos, placares de campeonato, reviews etc.
Seu design foi baseado na própria listagem de notícias do Google, visando a simplicidade.

Quanto a parte técnica, desenvolvemos uma API em Python para fazer WebScraping do site <a href="https://flowgames.gg/"  target="_blank"> FlowGames </a>, além disso, utilizamos o **FireBase DataStore** para armazenar as informações obtidas do site, após isso o nosso aplicativo puxa as informações do banco e imprime na tela, fazendo com que o conteúdo do aplicativo sempre seja atualizado automáticamente. Mais detalhes podem ser encontradas nessa branch: [API-WEBSCRAPP](https://github.com/JnksDavu/GameStellar/tree/API-WEBSCRAPP-FINAL).



O aplicativo conta com as seguintes funcionalidades:

## Tela de login:
- Login;
- Cadastro;
- Recuperação de senha.

## Tela de Cadastro:
- Fazer cadastro utilizando dados pessoais;
>[!NOTE]
>A tela de login e cadastro possuem conexão e válidação com o banco de dados FireBase, portanto, os dois são funcionais.


## Tela Home:
- Listagem de notícias;
- Seleção de notícia;
- Menu Drawer;
- Favoritar Notícias;

## Página de Favoritos:
- Clicar na notícia desejada;
- Desfavoritar a notícia

## Menu Drawer:
- Voltar para a Home;
- Selecionar categorias de notícias;
- Sair para a tela de Login;

## Tela individual de cada notícia:
- Ler a notícia;

## Como executar/importar o projeto

- Certifique-se de que o Flutter esteja na versão 3.10.1 e o Dart na versão 3.0.1;
- Importe o projeto para sua IDE de preferência (eu estou utilizando o Android Studio Giraffe | 2022.3.1 Patch 1);
- Certifique-se de que a IDE esteja com os plugins Flutter e Dart instalados nas versões citadas acima;
- Vá em `File > Settings > Languages & Frameworks > Flutter` e insira o caminho da pasta do SDK do Flutter em `Flutter SDK path`;
- Abra o arquivo `pubspec.yaml` e clique em `pub get` para que as dependências (pacotes) utilizadas no projeto sejam carregadas;
- Execute a aplicação.
