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
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/api/site/all'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final dataSite = jsonDecode(response.body);
      setState(() {
        _sites = dataSite;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load sites');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenWidth);
    final fontCardColor = Color(0xFF2E4179);
    final backGroundColor = Colors.white;

    return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          title: Text("Choice Page"),
          backgroundColor: Color(0xFF2E4179),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Center(child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(fontCardColor),
                            minimumSize: MaterialStateProperty.all<Size>(Size(350, 180)),

                          ),
                          onPressed: () {
                            return nextPage(context);
                          },
                          child: Text(
                            "Sondage sur Agent ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: constraints.maxHeight * 0.25,
                            width: constraints.maxWidth * 0.15
                        ), // add space between the buttons
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(fontCardColor),
                            minimumSize: MaterialStateProperty.all<Size>(Size(350, 180)),

                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return SurveyPage(agent: null, site: _sites[0]);
                            }));
                          },
                          child: Text(
                            "Sondage sur la CDC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                ),
              ],
            ),);
          } else {
            return PageView.builder(itemBuilder: (_, index) {
              return Container(
                alignment: Alignment.center,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(fontCardColor),
                        minimumSize: MaterialStateProperty.all<Size>(Size(300, 120)),

                      ),
                      onPressed: () {
                        return nextPage(context);
                      },
                      child: Text(
                        "Agent Survey",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.25),
                    // add space between the buttons
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(fontCardColor),
                        minimumSize: MaterialStateProperty.all<Size>(Size(300, 120)),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return SurveyPage(agent: null, site: _sites[index]);
                        }));
                      },
                      child: Text(
                        "Office Survey",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          }
        }));
  }
}
