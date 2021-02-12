import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final color = const Color(0xFF3E3EB8);

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyProfile(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyProfile extends StatefulWidget {
  MyProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          title: Text('Profil'),
        ),
        body: Card(
          color: color,
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset('images/logo.png',
                          width: 100, height: 100),
                    ),
                    Text(
                      username,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      surnameUser,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      emailUser,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                    SizedBox(height: 25.0),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
