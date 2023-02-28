import 'package:flutter/material.dart';
import 'package:survey/model/agent.dart';
import 'package:survey/model/question.dart';
import 'package:survey/pages/thankyou_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Question> fetchQuestion() async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:8080/api/ask/id/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Question.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load question');
  }
}


class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}





class _SurveyPageState extends State<SurveyPage> {
  late Future<Question> futureQuestion;
  @override
  void initState() {
    super.initState();
    futureQuestion = fetchQuestion();
  }
  double value = 0.25;
  int i = 0;
  List emoji = ["😃", "😊", "🙁", "😡"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey PAGE"),
      ),
      body:Center(
        child: FutureBuilder<Question>(
          future: futureQuestion,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data!.text);
            }else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      )
    );
  }
}
