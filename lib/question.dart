import 'package:flutter/material.dart';

import 'main.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  var score = 0;
  var currentQuestion = 0;

  var quiz = [
    {
      "question": "La devise du Cameroun est l'union fait la force",
      "url": "images/belgique.jpg",
      "reponses": [
        {"reponse": "Vrai", "valeur": false, "message": ""},
        {"reponse": "Faux", "valeur": true, "message": ""}
      ]
    },
    {
      "question": "La lune va finir par tomber sur terre à cause de la gravité",
      "url": "images/lune.jpg",
      "reponses": [
        {
          "reponse": "Vrai",
          "valeur": false,
          "message": "Au contraire la lune s'éloigne"
        },
        {"reponse": "Faux", "valeur": true, "message": ""}
      ]
    },
    {
      "question": "La Russie est plus grande en superficie que Pluton",
      "url": "images/russie.jpg",
      "reponses": [
        {"reponse": "Vrai", "valeur": true, "message": ""},
        {"reponse": "Faux", "valeur": false, "message": ""}
      ]
    },
    {
      "question": "Nyctalope est une race naine d'antilope",
      "url": "images/nyctalope.jpg",
      "reponses": [
        {"reponse": "Vrai", "valeur": true, "message": ""},
        {
          "reponse": "Faux",
          "valeur": false,
          "message": "C'est une aptitude à voir dans le noir"
        }
      ]
    },
    {
      "question": "Le Commodore 64 est l'ordinateur de bureau le plus vendu",
      "url": "images/commodore.jpg",
      "reponses": [
        {"reponse": "Vrai", "valeur": true, "message": ""},
        {"reponse": "Faux", "valeur": false, "message": ""}
      ]
    },
    {
      "question": "le nom du drpeau des pirates est black skull",
      "url": "images/pirate.png",
      "reponses": [
        {
          "reponse": "Vrai",
          "valeur": false,
          "message": "Il est appelé Jolly Roger"
        },
        {"reponse": "Faux", "valeur": true, "message": ""}
      ]
    },
    {
      "question": "Haddock est le nom du chien de Tintin",
      "url": "images/tintin.jpg",
      "reponses": [
        {"reponse": "Vrai", "valeur": false, "message": "C'est Milou"},
        {"reponse": "Faux", "valeur": true, "message": ""}
      ]
    },
    {
      "question": "La barbe des Pharaons était fausse",
      "url": "images/pharaon.jpg",
      "reponses": [
        {
          "reponse": "Vrai",
          "valeur": true,
          "message": "A l'époque déjà ils utilisaient des postiches"
        },
        {"reponse": "Faux", "valeur": false, "message": ""}
      ]
    },
    {
      "question": "Au Québec tire toi une bûche veut dire viens t'asseoir",
      "url": "images/buche.jpg",
      "reponses": [
        {
          "reponse": "Vrai",
          "valeur": true,
          "message": "La bûche, fameuse chaise de bûcheron"
        },
        {"reponse": "Faux", "valeur": false, "message": ""}
      ]
    },
    {
      "question": "Le module lunaire Eagle  possédait plus de 4Ko de Ram",
      "url": "images/eagle.jpg",
      "reponses": [
        {
          "reponse": "Vrai",
          "valeur": true,
          "message": "Dire que je me plains avec mes 8Go de RAM sur mon mac"
        },
        {"reponse": "Faux", "valeur": false, "message": ""}
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Le Quizz"),
      ),
      body: Column(
        children: [
          Container(
            height: 30,
          ),
          Center(
            child: Text("Question numéro ${currentQuestion + 1}"),
          ),
          Container(
            height: 30,
          ),
          Center(
            child: Text("Score:${score}/${currentQuestion}"),
          ),
          Container(
            height: 30,
          ),
          Center(
            child: Image.asset(quiz[currentQuestion]['url']),
          ),
          Container(
            height: 50,
          ),
          Center(
            child: Text(quiz[currentQuestion]['question']),
          ),
          Container(
            height: 30,
          ),
          Center(
            child: Row(
              children: [
                Container(
                  width: 110,
                ),
                ...(quiz[currentQuestion]['reponses']
                        as List<Map<String, Object>>)
                    .map((reponse) {
                  return MaterialButton(
                    onPressed: (() =>
                        alert(reponse['message'], reponse['valeur'])),
                    child: Text(
                      reponse['reponse'],
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                  );
                }),
                Container(
                  width: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Null> alert(String message, bool valeur) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (valeur) {
            return AlertDialog(
              title: Center(
                  child: Text("C'est gagné",
                      style: TextStyle(color: Colors.green))),
              content: Column(
                children: [
                  Container(height: 30),
                  Image.asset("images/vrai.jpg"),
                  Container(height: 30),
                  Text(message),
                  Container(height: 30),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (currentQuestion < 9) {
                        currentQuestion++;
                        score++;
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        resultat();
                      }
                    });
                  },
                  child: Text("Au suivant"),
                )
              ],
            );
          } else {
            return AlertDialog(
              title: Center(
                  child: Text("Oups! perdu...",
                      style: TextStyle(color: Colors.red))),
              content: Column(
                children: [
                  Container(height: 30),
                  Image.asset("images/faux.jpg"),
                  Container(height: 30),
                  Text(message),
                  Container(height: 30),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (currentQuestion < 9) {
                        currentQuestion++;
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        resultat();
                      }
                    });
                  },
                  child: Text("Au suivant"),
                )
              ],
            );
          }
        });
  }

  Future<Null> resultat() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("C'est fini", style: TextStyle(color: Colors.blue)),
            content: Text("Votre score : ${score}/9"),
            actions: [
              FlatButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  });
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }
}
