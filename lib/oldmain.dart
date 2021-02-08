/* import 'package:flutter/material.dart';
import 'package:flutter_app/body.dart';
import 'package:flutter_app/question.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(   
        appBar: new AppBar(
          title: Text("Incidenz"),
        ),
        body: Column(
          children: [
            Center(
              child: Image.asset(
                'images/cover.jpg',
                height: 400,
                width: 600,
                scale: 2,
              ),
              heightFactor: 1.2,
            ),
            MaterialButton(
              child: Text(
                "Commencer le quiz",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 2.0,
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Question()));
              },
              color: Colors.blue,
            )
          ],
        ));
  }
}
 */
