import 'package:flutter/material.dart';
import 'package:survey/model/agent_model.dart';

class SurveyPage extends StatefulWidget {
  final AgentModel agentModel;
  const SurveyPage({Key? key, required this.agentModel}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  double value = 0.001;
  int i = 0;
  List step = ["1", "2", "3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey PAGE"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Veuillez répondre aux questions en sélectionnant un des emoji",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text("Agent sélection: " + widget.agentModel.name),
          SizedBox(
            height: 40,
          ),
  Text('${i}' +
      '/' +step.length.toString()),
          SizedBox(
            height: 10,
          ),
          Text(
            "Question ${i}: Comment avez-vous trouvé l'accueil de l'agent ?",
            style: TextStyle(
              fontSize: 22,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 100, left: 100, top: 20),
            alignment: Alignment.center,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.green,
              minHeight: 5,
              value: value,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(40),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        value = value + 0.333;
                        i = i +1;
                       // print(value);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent
                        ,),
                        child: Text(
                          "text",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    );

                  }),

            ),
      ],
    ),
    );
  }
}
