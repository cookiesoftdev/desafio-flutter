import 'package:desafio_flutter/page/word_list_screen.dart';
import 'package:desafio_flutter/provider/WordProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locator.dart';

/**
 * Método main que inicia a execução do aplicativo
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

/**
 * Widget MyApp que executa a tela inicial do aplicativo
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WordProvider()),
      ],
      child: MaterialApp(
        title: 'Word Dictionary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WordListScreen(),
      ),
    );
  }
}