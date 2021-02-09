import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: StarWarsData(),
  ));
}

class StarWarsData extends StatefulWidget {
  @override
  StarWarsState createState() => StarWarsState();
}

class StarWarsState extends State<StarWarsData> {
  final String url = "https://jsonplaceholder.typicode.com/comments";
  List data;

  Future<String> getSWData() async {
    var res = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      'Accept': "*/*",
      'connection': 'keep-alive',
    });

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Starships"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Text(data[2]["name"]),
          ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Text("Name: "),
                                Text(data[index]["name"],
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black87)),
                              ],
                            )),
                      ),
                      Card(
                        child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Text("Model: "),
                                Text(data[index]["body"],
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.red)),
                              ],
                            )),
                      ),
                      Card(
                        child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              children: <Widget>[
                                Text("Cargo Capacity: "),
                                Text(data[index]["email"],
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.black87)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}
