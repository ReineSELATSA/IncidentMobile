import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

// ignore: must_be_immutable
class ListeIncidents extends StatefulWidget {
  @override
  _IncidentState createState() => _IncidentState();
}

class _IncidentState extends State<ListeIncidents> {
  @override
  Widget build(BuildContext context) {
    final appTitle = "Liste des incidents";
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: Mylist());
  }
}

class Mylist extends StatefulWidget {
  @override
  MylistState createState() {
    return MylistState();
  }
}

class MylistState extends State<Mylist> {
  var compteur = 0;
  var quiz = [
    {
      "titre": "La devise ",
      "image": "images/belgique.jpg",
      "description": "La devise du Cameroun est l'union fait la force",
      "emplacement": "Douala",
      "statut": "en cours d'excécution",
      "categorie": "en cours d'excécution",
      "date": "2019"
    },
    {
      "titre": "La devise ",
      "image": "images/belgique.jpg",
      "description": "La devise du Cameroun est l'union fait la force",
      "emplacement": "Douala",
      "statut": "en cours d'exécution",
      "categorie": "en cours d'excécution",
      "date": "2019"
    },
    {
      "titre": "La devise ",
      "image": "images/belgique.jpg",
      "description": "La devise du Cameroun est l'union fait la force",
      "emplacement": "Douala",
      "statut": "en cours d'excécution",
      "categorie": "en cours d'excécution",
      "date": "2019"
    },
    {
      "titre": "La devise ",
      "image": "images/belgique.jpg",
      "description":
          "La devise du TGF Y UF UTYF KGUYG  UYG GYUU GYUYG YG GUYG UFT YG  G FYYY UTFHV HVGHFYF FYFG VGOB CJUG VTYUYGIU VUYJV DUKUMOUYRRFD GHFD FGDYTD TF FYU  HF FYTFF FY  D  Cameroun est l'union fait la force",
      "emplacement": "Douala",
      "statut": "en cours d'excécution",
      "categorie": "en cours d'excécution",
      "date": "2019"
    },
  ];

  List data = [];

  Future<String> getSWData() async {
    var res = await http.get('https://jsonplaceholder.typicode.com/comments');

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    if (data.length != 0) {
      return new Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.length,
            itemBuilder: (BuildContext listcontext, int index) {
              return Card(
                  child: InkWell(
                onTap: () {
                  _information(context, data, index);
                },
                child: Row(
                  children: [
                    Image.asset(
                      quiz[2]['image'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 130.0,
                      child: Column(
                        children: [
                          Text(data[index]['name']),
                          Text(data[index]['email'])
                        ],
                      ),
                    ),
                  ],
                ),
              ));
            }),
      );
    } else {
      return Text("pas d'incidents enregistrés");
    }
  }
}

_information(context, data, index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  data[index]['name'],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Text(
                  data[index]['email'],
                  style: TextStyle(fontSize: 12),
                ),
                Container(
                  child: _result(data[index]['name']),
                ),
                Container(
                  height: 20,
                ),
                Text(
                  'Description',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Text(data[index]['body']),
                Container(
                  height: 20,
                ),
                Text(
                  'Emplacemzent',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Text(
                  data[index]['email'],
                ),
                Container(
                  height: 20,
                ),
                Text(
                  'Categorie',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Text(
                  data[index]['name'],
                ),
                Text(
                  'Medias',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

_result(name) {
  if (name == "en cours d'excécution") {
    return Row(
      children: [
        Icon(Icons.autorenew),
        Text('Incident en cours de traitement')
      ],
    );
  } else if (name == "signalé") {
    return Row(
      children: [Icon(Icons.dangerous), Text('Incident signalé')],
    );
  } else {
    return Row(
      children: [Icon(Icons.verified), Text('Incident traité')],
    );
  }
}
