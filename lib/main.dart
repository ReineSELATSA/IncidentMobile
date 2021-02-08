import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ListeIncidents.dart';
import 'addForm.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SELATSA',
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool oui = false;

  GoogleMapController _controller;
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(24.903623, 67.198367));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('df'),
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red, Colors.white])),
            ),
            ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.person),
                onTap: () {
                  /* 
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => quiz())); */
                }),
            Divider(
              color: Colors.redAccent,
            ),
            ListTile(
                title: Text(
                  'Paramètres',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.settings),
                onTap: () {
                  /* 
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => quiz())); */
                }),
            Divider(
              color: Colors.redAccent,
            ),
            ListTile(
                title: Text(
                  'A propos de Incidenz',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.account_box),
                onTap: () {
                  /* 
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => quiz())); */
                }),
            Divider(
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text('Incidenz'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
            padding: const EdgeInsets.only(right: 20.0),
          )
        ],
        elevation: 10.0,
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        onTap: (cordinate) {
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddForm()));
        },
        elevation: 10.0,
        tooltip: 'Changer oui',
        child: new Icon(Icons.add),
      ),
      /*   persistentFooterButtons: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: null,
          color: Colors.red,
          iconSize: 28,
          focusColor: Colors.red,
          padding: const EdgeInsets.only(right: 12),
        ),
        IconButton(icon: Icon(Icons.remove), onPressed: null)
      ], */
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int i) {
          if (i == 0) {
            print("Recherche");
          } else if (i == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListeIncidents()));
          }
        },
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text("Right"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.navigation_sharp),
            title: new Text("43"),
          ),
        ],
      ),
    );
  }

  void boutonDelete() {
    setState(() {
      oui = !oui;
    });
  }
}

void quiz() {}
