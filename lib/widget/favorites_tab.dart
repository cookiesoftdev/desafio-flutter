import 'package:desafio_flutter/page/word_detail_screen.dart';
import 'package:desafio_flutter/provider/WordProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Montamos a lógica de provider para compartilhar os objetos/palavras salvas nas preferências como favorito.
 */
class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
      ),
      itemCount: wordProvider.favorites.length,
      itemBuilder: (context, index) {
        final word = wordProvider.favorites[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordDetailScreen(
                  words: wordProvider.favorites,
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
                    icon: const Icon(
                      Icons.favorite,
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