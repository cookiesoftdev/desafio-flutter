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
   
