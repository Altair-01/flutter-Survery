import 'dart:convert';
import 'package:survey/model/question.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

class DatabaseServices{
  static Future<List<String>> getQuestions() async {
    http.Response response = await http.get(Uri.parse('http://10.0.2.2:8080/api/ask/all'), headers: headers,);
    print(response.body);
    final data = jsonDecode(response.body) ;
    List<Questions> questions = [];
    for (Map questionMap in data){
      Question question = Question.fromMap(questionMap);
      questions.add(question);
    }

    return questions;

  }

}