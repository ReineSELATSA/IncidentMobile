import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Pages extends StatelessWidget {
  Pages(String title) {
    this.title = title;
  }

  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          "Je suis une nouvelle page",
          textScaleFactor: 2.0,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.teal,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
