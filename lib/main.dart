import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/inscription.dart';
import 'package:flutter_app/profile.dart';
import 'accueil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final color = const Color(0xFF3E3EB8);
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SELATSA',
      home: new MyHomePage(title: 'Incidenz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String username = '';
String idUser = '';
String surnameUser = '';
String emailUser = '';
Future connexionUser(
    String email, String password, BuildContext context) async {
  var Url =
      "http://192.168.43.74:8080/Connexion/connexionUser/$email/$password";
  var response = await http.get(Url);

  var resBody = json.decode(response.body);
  var user = resBody['returnValue'];
  username = user['nom'];
  idUser = user['idUser'];
  surnameUser = user['prenom'];
  emailUser = user['email'];

  Map responseString = json.decode(response.body);
  if (responseString['returnValue'] != null) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return Accueil();
    }), (route) => false);
  } else {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
            title: 'Connexion échouée',
            content: 'Bien vouloir entrer les bon identifiants');
      },
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 12.0);

  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          "images/logo.png",
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 25.0),

                      // TextFormField for email address

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        controller: _emailController,
                        validator: validateEmail,
                        onSaved: (value) => _email = value,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Adresse email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),

                      SizedBox(height: 25.0),

                      // TextFormField for email address

                      TextFormField(
                        autofocus: false,
                        obscureText: true,
                        controller: _passwordController,
                        validator: validatePassword,
                        onSaved: (value) => _password = value,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Mot de passe",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),

                      SizedBox(height: 25.0),

                      Divider(color: Colors.black), // divider

                      SizedBox(height: 20.0),

                      Material(
                        // login button
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20.0),
                        color: color,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              connexionUser(email, password, context);
                            } else {
                              setState(() {
                                // validation error
                                _autoValidate = true;
                              });
                            }
                          },
                          child: Text("Se connecter",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ),
                      Material(
                        // login button
                        color: Colors.transparent,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Inscription();
                            }));
                          },
                          child: Text(
                            "Créer un compte",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String validatePassword(String value) {
  Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "Champs obligatoire";
  } else if (!regex.hasMatch(value))
    return 'Alphabet, nombres, caractères spéciaux';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "Champs obligatoire";
  } else if (!regex.hasMatch(value))
    return 'Entrez une adresse valide';
  else
    return null;
}
