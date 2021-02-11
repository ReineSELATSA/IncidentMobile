import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'accueil.dart' as file;

class AddForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<AddForm> {
  @override
  Widget build(BuildContext context) {
    final appTitle = "Formulaire de déclaration d'incident";
    return new Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: SingleChildScrollView(child: MyCustomForm()));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

final List<Map<String, dynamic>> _items = [
  {
    'value': 'Dégradation du sol',
    'label': 'Dégradation du sol',
  },
  {
    'value': 'Signalisation',
    'label': 'Signalisation',
  },
  {
    'value': 'Malpropreté',
    'label': 'Malpropreté',
  },
  {
    'value': 'Eclairage',
    'label': 'Eclairage',
  },
  {
    'value': 'Animaux et végétaux',
    'label': 'Animaux et végétaux',
  },
  {
    'value': 'Incidents réparés',
    'label': 'Box Label',
  },
];

Future registerEmployees(String titre, String categorie, String description,
    double latitude, double longitude, BuildContext context) async {
  var Url =
      "http://192.168.43.1:3000/GestionIncident/createIncident/USERKAKO2749/$titre/$categorie/$description";
  var response = await http.post(Url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "titre": titre,
        "categorie": categorie,
        "description": description,
      }));

  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(
            title: 'Backend Response',
            content: "L'incident a été enregistré avec succès");
      },
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: 'gff', content: "Vérifiez vos champs");
      },
    );
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  static double longitude;
  static double latitude;
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController titre = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController emplacement = new TextEditingController();
  TextEditingController categorie = new TextEditingController();
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';
  File _file;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    //_initialValue = 'starValue';
    categorie = TextEditingController(text: 'starValue');
    _getUserLocation();
    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = 'circleValue';
        categorie.text = 'circleValue';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    titre.text = '';
    description.text = '';
    emplacement.text = '';
    categorie.text = '';
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 18, bottom: 4),
                        child: Text(
                          "Photos",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        )),
                    Row(
                      children: [
                        InkWell(
                          onTap: getImage,
                          child: Image.asset(
                            'images/add.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Center(
                          child: _file == null
                              ? Text('')
                              : Image.file(
                                  _file,
                                  width: 100,
                                  height: 100,
                                ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Catégorie",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        )),
                    SelectFormField(
                      initialValue: 'value',
                      items: _items,
                      onChanged: (val) => setState(() => _valueChanged = val),
                      validator: (val) {
                        setState(() => _valueToValidate = val);
                        return null;
                      },
                      onSaved: (val) => setState(() => _valueSaved = val),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Titre",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        )),
                    TextFormField(
                      controller: titre,
                      decoration: const InputDecoration(
                          hintText: 'Entrer un titre pour le signalement',
                          alignLabelWithHint: false,
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 25)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Requis';
                        }
                        return null;
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        )),
                    TextFormField(
                      controller: description,
                      maxLines: 2,
                      decoration: const InputDecoration(
                          hintText:
                              'Entrer une description pour le signalement',
                          alignLabelWithHint: false,
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 25)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez remplir le champs';
                        }
                        return null;
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Emplacement",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        )),
                    TextFormField(
                      controller: emplacement,
                      decoration: const InputDecoration(
                          hintText: 'Entrer un emplacement pour le signalement',
                          alignLabelWithHint: false,
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 25)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez remplir le champ';
                        }
                        return null;
                      },
                    ),
                    new Container(
                        padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                        child: new RaisedButton(
                            child: const Text('Submit'),
                            onPressed: () {
                              // It returns true if the form is valid, otherwise returns false
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.

                                String titr = titre.text;
                                String cat = categorie.text;
                                String des = description.text;
                                registerEmployees(titr, cat, des, latitude,
                                    longitude, context);
                                titre.text = '';
                                categorie.text = '';
                                description.text = '';
                              }
                            })),
                  ],
                ),
                padding: EdgeInsets.all(12))));
  }
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
