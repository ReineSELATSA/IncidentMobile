import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final color = const Color(0xFF3E3EB8);

class Inscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyInscription(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyInscription extends StatefulWidget {
  MyInscription({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyInscriptionState createState() => _MyInscriptionState();
}

Future registerUser(String name, String surname, String email, String password,
    BuildContext context) async {
  var Url = "http://192.168.43.74:8080/GestionUser/createUser";
  var response = await http.post(Url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "nom": name,
        "prenom": surname,
        "email": email,
        "password": password
      }));

  Map responseString = json.decode(response.body);
  if (responseString['returnValue'] != null) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: 'Backend Response', content: response.body);
      },
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyApp();
    }));
  } else {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
            title: 'Inscription échouée',
            content: 'Adresse email déjà utilisée. Bien vouloir la changer');
      },
    );
  }
}

class _MyInscriptionState extends State<MyInscription> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 12.0);

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _password2Controller = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  String _surname;

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

                      SizedBox(height: 15.0),

                      // TextFormField for email address

                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: _nameController,
                        onSaved: (value) => _name = value,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            hintText: "Nom",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      SizedBox(height: 15.0),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: _surnameController,
                        onSaved: (value) => _surname = value,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            hintText: "Prénom",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),

                      SizedBox(height: 15.0),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        controller: _emailController,
                        validator: validateEmail,
                        onSaved: (value) => _email = value,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),

                      SizedBox(height: 15.0),

                      // TextFormField for email address

                      TextFormField(
                        autofocus: false,
                        controller: _passwordController,
                        validator: validatePassword,
                        onSaved: (value) => _password = value,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),

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
                              // If the form is valid, display a Snackbar.
                              String name = _nameController.text;
                              String surname = _surnameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              registerUser(
                                  name, surname, email, password, context);
                              /* 
                              MyAlertDialog(
                                  title: 'Inscription réussie',
                                  content:
                                      'Vous pouvez désormais vous connecter'); */

                            } else {
                              setState(() {
                                // validation error
                                _autoValidate = true;
                              });
                            }
                          },
                          child: Text("S'inscrire",
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
                              return MyApp();
                            }));
                          },
                          child: Text(
                            "J'ai déjà un compte",
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
    return "Password is Required";
  } else if (!regex.hasMatch(value))
    return 'Password required: Alphabet, Number & 8 chars';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
