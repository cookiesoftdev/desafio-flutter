import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:desafio_flutter/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test navigation from word list to word detail and back', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Provide mock data
    final words = [
      {'word': 'hello', 'phonetic': 'həˈləʊ', 'meanings': ['A greeting']},
      {'word': 'world', 'phonetic': 'wɜːld', 'meanings': ['The earth, together with all of its countries and peoples']}
    ];

    // Find the word list and ensure it's displayed
    final wordListFinder = find.byType(ListView);
    expect(wordListFinder, findsOneWidget);

    // Find a word in the list and tap it
    final wordFinder = find.text('hello');
    expect(wordFinder, findsOneWidget);
    await tester.tap(wordFinder);
    await tester.pumpAndSettle();

    // Ensure word details are displayed
    expect(find.text('Phonetic: həˈləʊ'), findsOneWidget);
    expect(find.text('A greeting'), findsOneWidget);

    // Tap back button to go to the word list
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    // Ensure the word list is displayed again
    expect(wordListFinder, findsOneWidget);
  });
}
