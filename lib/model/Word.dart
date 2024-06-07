/**
 * Modelo definido devido a estrutura da Free Dictionary API
 */
class Word {
  final String word;
  final String phonetic;
  final List<String> meanings;

  Word({required this.word, required this.phonetic, required this.meanings});

  factory Word.fromJson(Map<String, dynamic> json) {
    List<String> meanings = [];
    if (json['meanings'] != null) {
      for (var meaning in json['meanings']) {
        meanings.add(meaning['definitions'][0]['definition']);
      }
    }
    return Word(
      word: json['word'],
      phonetic: json['phonetic'] ?? '',
      meanings: meanings,
    );
  }
}
