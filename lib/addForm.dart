import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:image_picker/image_picker.dart';

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

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titre = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController emplacement = new TextEditingController();
  TextEditingController categorie = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    titre.text = '';
    description.text = '';
    emplacement.text = '';
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
                    Image.asset(
                      'images/add.png',
                      height: 100,
                      width: 100,
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
                      onChanged: (value) => print(value),
                      onSaved: (value) => print(value),
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
                          return 'Please enter valid phone number';
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
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Data is in processing.')));
                              }
                            })),
                  ],
                ),
                padding: EdgeInsets.all(12))));
  }
}
