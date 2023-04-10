import 'package:flutter/material.dart';
import 'package:survey/model/agent.dart';
import 'package:survey/model/site.dart';
import 'package:survey/model/question.dart';
import 'package:survey/pages/thankyou_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SurveyPage extends StatefulWidget {
  final dynamic? agent;
  final dynamic? site;

  const SurveyPage({Key? key,required this.site, required this.agent}) : super(key: key);
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List _questions = [];
  int _currentIndex = 0;
  List emoji = ["😃", "😊", "🙁", "😡"];
  List _selectedEmoji = [];

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  Future<void> fetchQuestion() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/api/ask/all'));
    final data = jsonDecode(response.body);
    setState(() {
      _questions = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final ctx = context; // obtain the current BuildContext
    return Scaffold(
        appBar: AppBar(
          title: Text("Survey PAGE"),
          backgroundColor: Color(0xFF2E4179),

        ),
        body: SafeArea(
            child: _questions.isEmpty
                ? Center(
                    child: ElevatedButton(
                      onPressed: fetchQuestion,
                      child: const Text('Load Questions'),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        'Question: ' +
                            (_currentIndex < _questions.length
                                ? _questions[_currentIndex]['id'].toString()
                                : _questions.length.toString()) +
                            '/' +
                            _questions.length.toString(),
                        style: TextStyle(
                            color: Color(0xFF2E4179),
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      // PROGRESS BAR
                      Container(
                        width: screenWidth*0.7,
                        child:LinearProgressIndicator(
                          value: (_currentIndex / _questions.length),
                          minHeight: 10,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),

                      ),
                      SizedBox(height: 25),
                      //QUESTION
                      Text(
                        _currentIndex < _questions.length
                            ? _questions[_currentIndex]['text']
                            : "Terminé !",
                        style: TextStyle(color: Color(0xFF96322E),
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
                      //REPONSE
                      Text(
                        "Réponses:",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF2E4179),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      //CETTE ROW NE CONCERNE QUE L'AFFICHAGE DES REPONSES(EMOJI)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0; i < emoji.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  _selectedEmoji.add(emoji[i]);
                                  print(emoji[i]); // print the corresponding emoji to the console

                                  _incrementIndex(ctx);
                                 // print(_currentIndex);
                                //  print(_questions.length);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    emoji[i],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 50),//100 comme fontsize
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  )));
  }

  void _incrementIndex(BuildContext ctx) {
    setState(() {
      if (_currentIndex < _questions.length) {
        _currentIndex++;
      }
      if (_currentIndex == _questions.length) {
        // Convertir la liste en JSON
        String jsonSelectedEmoji = jsonEncode(_selectedEmoji);

        // Préparer les en-têtes de la requête
        Map<String, String> headers = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };

        // Préparer les données de la requête
        Map<String, dynamic> data = {
          'content': jsonSelectedEmoji,
          'agent': widget.agent,
          'site' : widget.site,
        };
        // Envoyer la requête POST
        http.post(Uri.parse('http://10.0.2.2:8080/api/answer/add'),
            headers: headers, body: jsonEncode(data)).then((response) {
          if (response.statusCode == 201 || response.statusCode == 200) {
            // Traitement en cas de succès
            Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
              return Thank();
            }));
          } else {
            // Traitement en cas d'échec
            print('Erreur ${response.statusCode}: ${response.reasonPhrase}');
          }
        }).catchError((error) {
          // Traitement en cas d'erreur
          print('Erreur lors de l\'envoi de la requête: $error');
        });
      }
    });
  }
}
