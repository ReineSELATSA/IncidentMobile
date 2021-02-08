import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListeIncidents extends StatefulWidget {
  Size screenSize;
  @override
  _IncidentState createState() => _IncidentState();
}

class _IncidentState extends State<ListeIncidents> {
  @override
  Widget build(BuildContext context) {
    final appTitle = "Formulaire de déclaration d'incident";
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
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: quiz.length,
          itemBuilder: (BuildContext listcontext, int index) {
            return Card(
                child: InkWell(
              onTap: () {
                _information(context, quiz, index);
              },
              child: Row(
                children: [
                  Image.asset(
                    quiz[index]['image'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 130.0,
                    child: Column(
                      children: [
                        Text(quiz[index]['titre']),
                        Text(quiz[index]['date']),
                        Text(quiz[index]['statut'])
                      ],
                    ),
                  ),
                ],
              ),
            ));
          }),
    );
  }
}

_information(context, quiz, index) {
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
                  quiz[index]['titre'],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Text(
                  quiz[index]['date'],
                  style: TextStyle(fontSize: 12),
                ),
                Container(
                  child: _result(quiz[index]['statut']),
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
                Text(quiz[index]['description']),
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
                  quiz[index]['emplacement'],
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
                  quiz[index]['categorie'],
                ),
                Text(
                  'Medias',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Image.asset(quiz[index]['image'])
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
