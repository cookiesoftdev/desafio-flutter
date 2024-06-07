# Word Dictionary App

Este é um aplicativo de dicionário de palavras desenvolvido em Flutter, que exibe uma lista de palavras em inglês, seus significados e fonéticas. Os usuários podem visualizar os detalhes das palavras e adicionar palavras aos favoritos.

## Funcionalidades

- **Lista de Palavras**: Exibe uma lista de palavras em inglês.
- **Detalhes da Palavra**: Mostra os detalhes de uma palavra selecionada, incluindo sua fonética e significados.
- **Favoritos**: Permite adicionar e remover palavras dos favoritos.

## Estrutura do Projeto

desafio_flutter/
├── lib/
│   ├── main.dart
│   ├── locator.dart
│   ├── locator.config.dart
│   ├── provider/
│   │   └── word_provider.dart
│   ├── model/
│   │   └── word.dart
│   ├── page/
│   │   ├── word_list_screen.dart
│   │   └── word_detail_screen.dart
│   ├── util/
│   │   └── DictionaryApi.dart
│   └── widget/
│       └── favorites_tab.dart
|       └── history_tab.dart
|       └── word_list_tab.dart
├── test/
│   ├── word_list_screen_test.dart
│   └── word_detail_screen_test.dart
├── test_driver/
│   └── integration_test.dart
├── integration_test/
│   └── app_test.dart
├── pubspec.yaml
└── README.md

## Instalação

1. **Clone o repositório:**

   ```sh
   git clone https://github.com/cookiesoftdev/desafio-flutter.git
   cd desafio-flutter

## Bibliotecas Utilizadas
* cupertino_icons: Ícones estilo Cupertino para iOS.
* http: Realiza requisições HTTP.
* provider: Gerenciamento de estado reativo.
* shared_preferences: Armazenamento de dados simples no dispositivo.
* audioplayers: Toca arquivos de áudio.
* get_it: Serviço de localização para injeção de dependências.
* injectable: Geração de código para injeção de dependências.
* injectable_generator: Ferramenta de geração de código para o injectable.
* connectivity_plus: Verificação do estado da conectividade com a internet.

## Dependências de Desenvolvimento
* flutter_test: Ferramentas para testes unitários e de integração.
* mockito: Biblioteca para criar mocks em testes.
* build_runner: Ferramenta para gerar código.
* flutter_driver: Ferramentas para testes de integração.
* integration_test: Suporte para testes de integração.

## Estrutura do Código

`main.dart`
O ponto de entrada do aplicativo. Configura o WordProvider usando ChangeNotifierProvider 
e define o tema e a tela inicial do aplicativo.

`locator.dart`
Configura e registra os serviços que serão usados pelo projeto.

`word_provider.dart`
Gerencia o estado da lista de palavras e favoritos. Notifica os ouvintes sobre as mudanças no estado.

`word.dart`
Define a classe Word que representa uma palavra, sua fonética e significados.

`word_list_screen.dart`
Exibe uma lista de palavras em inglês. Usa o WordProvider para obter a lista de palavras e navega 
para a tela de detalhes da palavra ao tocar em uma palavra.

`word_detail_screen.dart`
Exibe os detalhes de uma palavra selecionada, incluindo sua fonética e significados. 
Permite adicionar ou remover a palavra dos favoritos.

`dictionary_api.dart`
Realiza requisições HTTP para buscar dados de palavras da API Dictionary.