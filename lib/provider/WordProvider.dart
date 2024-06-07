import 'dart:convert';

import 'package:desafio_flutter/model/Word.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

/**
 * Provide que gerencia o estado da lista de palavras e fornece métodos para interagir com esse estado
 */
class WordProvider with ChangeNotifier {
  final List<Word> _words = [];
  final List<Word> _favorites = [];
  final List<Word> _history = [];
  int _currentPage = 0;
  final int _pageSize = 10000;

  List<Word> get words => _words;
  List<Word> get favorites => _favorites;
  List<Word> get history => _history;

  Future<void> loadWords() async {
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/dwyl/english-words/master/words_dictionary.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> wordsJson = jsonDecode(response.body);
      final keys = wordsJson.keys.toList();
      _words.addAll(keys.skip(_currentPage * _pageSize).take(_pageSize).map((word) => Word(word: word, phonetic: '', meanings: [])));
      _currentPage++;
      notifyListeners();
    } else {
      throw Exception('Failed to load words');
    }
  }

  void addWord(Word word) {
    _words.add(word);
    notifyListeners();
  }

  void toggleFavorite(Word word) {
    if (_favorites.contains(word)) {
      _favorites.remove(word);
    } else {
      _favorites.add(word);
    }
    notifyListeners();
  }

  void addToHistory(Word word) {
    if (!_history.contains(word)) {
      _history.add(word);
    }
    notifyListeners();
  }
}
