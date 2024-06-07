import 'package:desafio_flutter/page/word_detail_screen.dart';
import 'package:desafio_flutter/provider/WordProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Montamos a lógica de provider para compartilhar os objetos/palavras acessados na tela principal do app.
 */
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
      ),
      itemCount: wordProvider.history.length,
      itemBuilder: (context, index) {
        final word = wordProvider.history[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordDetailScreen(
                  words: wordProvider.history,
                  currentIndex: index,
                ),
              ),
            );
          },
          child: GridTile(
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(word.word, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        );
      },
    );
  }
}