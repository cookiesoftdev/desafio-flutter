import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

/**
 * Nessa classe aplicamos o conceito de injeção de dependência como solicitado
 * o seja a classe vai ser carregada/instanciada dinamicamente, sem precisar
 * que alguma outra classe crie ela manualmente.
 */
@injectable
class DictionaryApi {
  static const _baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  /**
   * Obtém dados da API dictionaryapi Free Dictionary API
   */
  Future<Map<String, dynamic>> fetchWordData(String word) async {
    final response = await http.get(Uri.parse('$_baseUrl$word'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[0];
    } else {
      throw Exception('Failed to load word data');
    }
  }
}
