import 'package:desafio_flutter/provider/WordProvider.dart';
import 'package:desafio_flutter/widget/favorites_tab.dart';
import 'package:desafio_flutter/widget/history_tab.dart';
import 'package:desafio_flutter/widget/word_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * Widget que lista as palavras retornadas da Free Dictionary API
 */
class WordListScreen extends StatefulWidget {
  const WordListScreen({super.key});

  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final wordProvider = Provider.of<WordProvider>(context, listen: false);
    wordProvider.loadWords();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Dictionary'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Word List'),
            Tab(text: 'History'),
            Tab(text: 'Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          WordListTab(),
          HistoryTab(),
          FavoritesTab(),
        ],
      ),
    );
  }
}
