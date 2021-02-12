import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final color = const Color(0xFF3E3EB8);

class Incidenz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyIncidenz(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyIncidenz extends StatefulWidget {
  MyIncidenz({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyIncidenzState createState() => MyIncidenzState();
}

class MyIncidenzState extends State<MyIncidenz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Profil'),
      ),
      body: Column(
        children: [
          SizedBox(height: 15.0),
          Text(
              "Incidenz est un service developpé par les étudiants de l'Institut Saint Jean."),
          SizedBox(height: 15.0),
          Text("DJIMKOUO NTEMDIEU Kevin"),
          SizedBox(height: 15.0),
          Text("NGALEU MOUATCHOUA Stephane"),
          SizedBox(height: 15.0),
          Text("NGUIMFACK KAZE Berthold"),
          SizedBox(height: 15.0),
          Text("SELATSA KEALACK Reine Audrey"),
          SizedBox(height: 15.0),
          Text("NGUIMFACK KAZE Berthold"),
          SizedBox(height: 15.0),
          Text("NGUIMFACK KAZE Berthold")
        ],
      ),
    );
  }
}
