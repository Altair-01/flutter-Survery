import 'package:flutter/material.dart';
import 'package:survey/pages/survey_page.dart';
import 'package:survey/model/agent_model.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  //Liste de 100 agent généré pour l'exemple
  final List<AgentModel> Agentdata =
      List.generate(10, (index) => AgentModel("Agent $index")).toList();

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
          itemCount: Agentdata.length,
          itemBuilder: (BuildContext ctx,index) {
            return InkWell(
              onTap: () {
                 Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
                  return SurveyPage(agentModel: Agentdata[index]);
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
                    Text(
                      Agentdata[index].name,
                      style: TextStyle(color: Colors.black87, fontSize: 24),
                    ),
                  ],
                ),
              ),

            );
          }),
    );
  }
}
