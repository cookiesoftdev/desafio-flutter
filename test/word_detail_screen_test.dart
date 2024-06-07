import 'package:desafio_flutter/model/Word.dart';
import 'package:desafio_flutter/page/word_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WordDetailScreen', () {
    testWidgets('should display word details', (WidgetTester tester) async {
      // Provide mock data
      final words = [
        Word(word: 'hello', phonetic: 'həˈləʊ', meanings: ['A greeting']),
        Word(word: 'world', phonetic: 'wɜːld', meanings: ['The earth, together with all of its countries and peoples'])
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: WordDetailScreen(words: words, currentIndex: 0),
        ),
      );

      // Verify the details are displayed
      expect(find.text('Phonetic: həˈləʊ'), findsOneWidget);
      expect(find.text('A greeting'), findsOneWidget);
    });
  });
}
