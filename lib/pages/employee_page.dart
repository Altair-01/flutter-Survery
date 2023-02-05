import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  //Liste de 100 agent généré pour l'exemple
  final List<Map> agents =
      List.generate(10, (index) => {"id": index, "name": "Agent $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Choisissez l'agent ")),
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(top: 20),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 360,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: agents.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                agents[index]["name"],
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

            );
          }),
    );
  }
}
