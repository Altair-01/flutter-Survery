import 'package:flutter/material.dart';
import 'package:survey/pages/employee_page.dart';
import 'package:survey/model/site.dart';
import 'package:survey/pages/survey_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:ui';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  List _sites = [];
  //late Future<Agent> futureAgent;
  // late Agent agent; // declare the variable to store the data
  @override
  void initState() {
    super.initState();
    fetchSite();
  }
  void nextPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return EmployeePage();
    }));
  }

  Future<void> fetchSite() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/api/site/all'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final dataSite = jsonDecode(response.body);
      setState(() {
        _sites = dataSite;
      });    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load sites');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = screenWidth * 0.5; // 10% of the screen width
    final fontCardColor = Color(0xFF033D5F);
    final backGroundColor = Color(0xFF012033);

    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text("Choice Page"),
      ),
      body: PageView.builder(itemBuilder: (_, index) {
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: paddingValue * 0.2),
                child: Container(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: fontCardColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 5, color: Colors.black87),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            spreadRadius: 30),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                            width: paddingValue * 0.82,
                            height: paddingValue,
                            child: Image.asset("images/office.png")),
                        SizedBox(height: 10),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                           //return SurveyPage(siteId: site.id);
                              return SurveyPage( agent:null,site: _sites[index]); //  return SurveyPage();

                            }));
                          },
                          child: Text(
                            "Office Survey",
                            style: TextStyle(
                                color: fontCardColor,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: fontCardColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 5, color: Colors.black87),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 10),
                          blurRadius: 10,
                          spreadRadius: 30),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                          width: paddingValue * 0.82,
                          height: paddingValue,
                          child: Image.asset("images/agent.png")),
                      SizedBox(height: 10),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          return nextPage(context);
                        },
                        child: Text(
                          "Agent Survey",
                          style: TextStyle(
                              color: fontCardColor,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
