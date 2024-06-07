import 'package:desafio_flutter/page/word_detail_screen.dart';
import 'package:desafio_flutter/provider/WordProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Widget responsável por Listar todas palavras consultadas no arquivo json estático(raw no github)
 */
class WordListTab extends StatelessWidget {
  const WordListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
      ),
      itemCount: wordProvider.words.length,
      itemBuilder: (context, index) {
        final word = wordProvider.words[index];
        return GestureDetector(
          onTap: () {
            wordProvider.addToHistory(word);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordDetailScreen(
                  words: wordProvider.words,
                  currentIndex: index,
                ),
              ),
            );
          },
          child: GridTile(
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(word.word, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(
                      wordProvider.favorites.contains(word)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      wordProvider.toggleFavorite(word);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}