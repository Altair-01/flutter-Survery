import 'package:flutter/material.dart';
import 'package:survey/pages/survey_page.dart';
import 'package:survey/model/agent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List _agents = [];
  //late Future<Agent> futureAgent;
 // late Agent agent; // declare the variable to store the data
  @override
  void initState() {
    super.initState();
    fetchAgent();
  }

  Future<void> fetchAgent() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/api/agent/all'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);
      setState(() {
        _agents = data;
      });    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load agent');
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Choisissez l'agent ")),
        backgroundColor: Color(0xFF2E4179),

      ),
      body: SafeArea(
        child: _agents.isEmpty
            ? Center(
          child: ElevatedButton(
            onPressed: fetchAgent,
            child: const Text('Load Agent'),
          ),
        )
            :GridView.builder(
            padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: _agents.length,//Agentdata.length,
            itemBuilder: (BuildContext ctx,index) {
              return InkWell(
                onTap: () {
                  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
                    return SurveyPage(agent: _agents[index],  site: null);//agent: Agentdata[index]);
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 5, color: Color(0xFF96322E),
                  ),
                    image: DecorationImage(
                     image: AssetImage('images/pro'+ _agents[index]['id'].toString() +'.jpg'),
                      fit: BoxFit.cover
                    )
                  ),
                  child:Align(
                    alignment: Alignment.bottomCenter,

                    child:  Text(
                      _agents[index]['fullName'],

                      //  Agent[index].fullName,
                      style: TextStyle(color: Color(0xFF2E4179), fontSize: 24, fontWeight:FontWeight.w800),
                    ),
                  ),
                ),

              );
            }),
      )
    );
  }
}
