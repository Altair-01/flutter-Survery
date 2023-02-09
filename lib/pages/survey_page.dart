import 'package:flutter/material.dart';
import 'package:survey/model/agent_model.dart';
import 'package:survey/pages/thankyou_page.dart';

class SurveyPage extends StatefulWidget {
  final AgentModel agentModel;
  const SurveyPage({Key? key, required this.agentModel}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  double value = 0.25;
  int i = 0;
  List emoji = ["😃", "😊", "🙁", "😡"];
  List question = [
    "Comment avez-vous trouvé l'accueil de l'agent",
    "L'agent a-t-il répondu à vos attentes",
    "Il y'a t-il eu des problèmes"
  ];
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
            height: 20,
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
          Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 5, color: Colors.black87), //<-- SEE HERE
            ),
            child: Image.asset('images/profile.jpg'),
          ),
          SizedBox(
            height: 40,
          ),
          Text('${i + 1}' + '/' + question.length.toString()),
          SizedBox(
            height: 10,
          ),

          Text(
            "Question ${i + 1}: ${question[i]}?",
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
                      print(emoji[index]);

                      if (i == question.length - 1 ) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return Thank();
                        }));
                      } else {
                        setState(() {
                          i = (i + 1) % question.length;  // This line has been added
                          value = value + 0.25;
                        });
                      }

                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      ),
                      child: Text(
                        emoji[index],
                        style: TextStyle(color: Colors.white, fontSize: 100),
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
