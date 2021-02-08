import 'package:flutter/material.dart';
import './page.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: Text(
        "Appuyez moi",
        style: TextStyle(fontSize: 12),
      ),
      onPressed: versNouvellePage,
    ));
  }

  void pressed() {
    setState(() {
      print("On m'a appuyé dessus");
    });
  }

  void snack() {
    SnackBar snackBar = new SnackBar(
      content: Text(
        "Je suis une snackbar",
        textScaleFactor: 1.5,
        style: TextStyle(color: Colors.black),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.white,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<Null> alert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Ceci est une alerte",
              textScaleFactor: 1.5,
            ),
            content: Text("Nous avons un problème avec notre application"),
            contentPadding: EdgeInsets.all(5.8),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    print('Abort');
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Annuler',
                    style: TextStyle(color: Colors.red),
                  )),
              FlatButton(
                  onPressed: () {
                    print('Proceed');
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Continuer',
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  Future<Null> dialog(String title, String desc) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: Text(
              title,
              textScaleFactor: 1.4,
            ),
            contentPadding: EdgeInsets.all(10.0),
            children: [
              new Text(desc),
              new Container(
                height: 20.0,
              ),
              new RaisedButton(
                  color: Colors.teal,
                  textColor: Colors.white,
                  child: Text("ok"),
                  onPressed: () {
                    print("Appuyé");
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  void versNouvellePage() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Pages("La seconde page");
    }));
  }
}

/* 
return new Container(
      child: ListView.builder(
          itemCount: 2, itemBuilder: (context, i) => Text('Moi ')),
    ); */
