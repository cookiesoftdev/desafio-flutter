import 'package:desafio_flutter/model/Word.dart';
import 'package:desafio_flutter/page/word_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('WordListScreen', () {
    testWidgets('should display a list of words', (WidgetTester tester) async {
      // Provide mock data
      final words = [
        Word(word: 'hello', phonetic: 'həˈləʊ', meanings: ['A greeting']),
        Word(word: 'world', phonetic: 'wɜːld', meanings: ['The earth, together with all of its countries and peoples'])
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: WordListScreen(),
        ),
      );

      // Verify the list is displayed
      expect(find.text('hello'), findsOneWidget);
      expect(find.text('world'), findsOneWidget);
    });
  });
}
