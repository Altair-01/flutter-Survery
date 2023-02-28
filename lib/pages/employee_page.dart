import 'package:flutter/material.dart';
import 'package:survey/pages/survey_page.dart';
import 'package:survey/model/agent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<Agent> fetchAgent() async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:8080/api/agent/id/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
      return Agent.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load question');
  }
}

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  late Future<Agent> futureAgent;
  @override
  void initState() {
    super.initState();
    futureAgent = fetchAgent();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Choisissez l'agent ")),
      ),
      body: GridView.builder(
          padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 360,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: 4,//Agentdata.length,
          itemBuilder: (BuildContext ctx,index) {
            return InkWell(
              onTap: () {
                 Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
                  return SurveyPage();//agent: Agentdata[index]);
                }));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 5, color: Colors.black87)
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset('images/profile.jpg'),
                    ),
                    SizedBox(height: 10),
                   /* Text(
                      Agentdata[index].fullName,
                      style: TextStyle(color: Colors.black87, fontSize: 24),
                    ),*/
                     FutureBuilder<Agent>(
            future: futureAgent,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Text(snapshot.data!.fullName);
              }else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
            ),
                  ],
                ),
              ),

            );
          }),
    );
  }
}
