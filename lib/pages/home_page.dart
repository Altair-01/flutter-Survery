import 'package:flutter/material.dart';
import 'package:survey/pages/employee_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void nextPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return EmployeePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      /*appBar: AppBar(
        title: Text("Survey App for senelec"),
      ),*/
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.language),
        onPressed: (){},
      ),
      body: PageView.builder(itemBuilder: (_, index) {
        return Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Système de sondage",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                    border: new Border.all(
                        color: Colors.green,
                        width: 5.0,
                        style: BorderStyle.solid),
                    /*       boxShadow: [
                           BoxShadow(
                              color: Colors.black87,
                              offset:  Offset(20.0, 10.0),
                              blurRadius: 10.0,
                              spreadRadius: 10.0
                          )
                        ],*/
                    color: Colors.black87,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("images/survey.png"),
                    )),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                width: 200,
                height: 100,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    return nextPage(context);
                  },
                  child: Text(
                    'Commencer',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
