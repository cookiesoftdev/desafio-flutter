import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desafio_flutter/locator.dart';
import 'package:desafio_flutter/model/Word.dart';
import 'package:desafio_flutter/util/DictionaryApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/**
 * Widget responsável por carregar as palavras consultadas e retornada da API
 */
class WordDetailScreen extends StatefulWidget {
  final List<Word> words;
  final int currentIndex;

  const WordDetailScreen({super.key, required this.words, required this.currentIndex});

  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  late AudioPlayer _audioPlayer;
  late DictionaryApi _dictionaryApi;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool _isMounted = false; // Variável de controle para verificar se o widget está montado

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _dictionaryApi = getIt<DictionaryApi>();
    _isMounted = true; // Definindo como verdadeiro quando o widget é montado

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (_isMounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (_isMounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (_isMounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false; // Definindo como falso quando o widget é desmontado
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause(String text) async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {

      try {
        final encodedText = Uri.encodeComponent(text);
        final apiUrl = 'https://code.responsivevoice.org/getvoice.php?t=$encodedText&tl=en&key=RyqKa2Np';
        print('API URL: $apiUrl'); // Verifique a URL gerada
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          await _audioPlayer.play(UrlSource(apiUrl));
        } else {
          print('Erro na API: ${response.statusCode}');
          print('Resposta: ${response.body}');
        }
      }catch(e){
        print('Erro ao tentar acessar a API: $e');
      }
    }
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<Map<String, dynamic>?> _fetchWordData(String word) async {
    if (!await _checkInternetConnection()) {
      throw Exception('No internet connection');
    }

    try {
      final response = await _dictionaryApi.fetchWordData(word);
      if (response == null) {
        throw Exception('No data found for the word');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to load word details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Word currentWord = widget.words[widget.currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentWord.word),
      ),
      body: FutureBuilder(
        future: _fetchWordData(currentWord.word),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found for the word'));
          } else {
            final wordData = snapshot.data as Map<String, dynamic>;
            final wordDetails = Word.fromJson(wordData);
            final phoneticText = wordDetails.phonetic.isNotEmpty
                ? wordDetails.phonetic
                : currentWord.word;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 180,  // Aumentando a altura para o triplo
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Phonetic: ${wordDetails.phonetic}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Meanings:', style: TextStyle(fontWeight: FontWeight.bold)),
                  for (var meaning in wordDetails.meanings) Text(meaning),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: () => _togglePlayPause(phoneticText),
                          ),
                          Expanded(
                            child: Slider(
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              value: position.inSeconds.toDouble(),
                              onChanged: (value) async {
                                final position = Duration(seconds: value.toInt());
                                await _audioPlayer.seek(position);
                                await _audioPlayer.resume();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTimeWithoutSeconds(position)),
                          Text(formatTimeWithoutSeconds(duration - position)),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: 50, // Altere a altura para criar um botão quadrado
                          child: ElevatedButton(
                            onPressed: widget.currentIndex > 0
                                ? () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WordDetailScreen(
                                    words: widget.words,
                                    currentIndex: widget.currentIndex - 1,
                                  ),
                                ),
                              );
                            }
                                : null,
                            child: Text('Voltar'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: 50, // Altere a altura para criar um botão quadrado
                          child: ElevatedButton(
                            onPressed: widget.currentIndex < widget.words.length - 1
                                ? () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WordDetailScreen(
                                    words: widget.words,
                                    currentIndex: widget.currentIndex + 1,
                                  ),
                                ),
                              );
                            }
                                : null,
                            child: Text('Próximo'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  String formatTimeWithoutSeconds(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    return '$minutes:${twoDigits(duration.inSeconds.remainder(60))}';
  }
}