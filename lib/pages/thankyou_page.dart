import 'package:flutter/material.dart';
import 'package:survey/pages/home_page.dart';

class Thank extends StatefulWidget {
  Thank({Key? key}) : super(key: key);

  @override
  State<Thank> createState() => _ThankState();
}

class _ThankState extends State<Thank> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return HomePage();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          "MERCI BEAUCOUP !",
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
