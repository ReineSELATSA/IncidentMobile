import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ListeIncidents.dart';
import 'dart:convert';
import 'addForm.dart';
import 'package:http/http.dart' as http;

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SELATSA',
      home: new MyAccueil(),
    );
  }
}

class MyAccueil extends StatefulWidget {
  @override
  MyAccueilState createState() {
    return MyAccueilState();
  }
}

class MyAccueilState extends State<MyAccueil> {
  final color = const Color(0xFF3E3EB8);

  List data;
  Future<String> getSWData() async {
    var res = await http
        .get('http://192.168.43.74:8080/GestionIncident/listIncident');

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody['returnValue'];
    });

    return "Success!";
  }

  final Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  BitmapDescriptor good;
  BitmapDescriptor bad;
  BitmapDescriptor middle;

  void setCustomMarker() async {
    good = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/good.png');
    bad = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/bad.png');

    middle = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/middle.png');
  }

  static LatLng _initialPosition;
  static double a;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    setCustomMarker();
    getSWData();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      a = position.longitude;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      data.forEach((element) {
        if (element['status'] == 'En cours de Traitement') {
          mapMarker = middle;
        } else if (element['status'] == 'En attente') {
          mapMarker = bad;
        } else {
          mapMarker = good;
        }
        _markers.add(
          Marker(
            markerId: MarkerId(element['titre']),
            position: LatLng(element['latitude'], element['longitude']),
            icon: mapMarker,
            infoWindow: InfoWindow(
                title: element['status'], snippet: element['categorie']),
          ),
        );
      });
    });
  }

  bool oui = false;

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
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Icon(Icons.person),
                onTap: () {
                  /* 
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => quiz())); */
                }),
            Divider(
              color: color,
            ),
            ListTile(
                title: Text(
                  'Paramètres',
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Icon(Icons.settings),
                onTap: () {
                  /* 
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => quiz())); */
                }),
            Divider(
              color: color,
            ),
            ListTile(
                title: Text(
                  'A propos de Incidenz',
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Icon(Icons.account_box),
                onTap: () {
                  /* 
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => quiz())); */
                }),
            Divider(
              color: color,
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        backgroundColor: color,
        title: new Text('Incidenz'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
            padding: const EdgeInsets.only(right: 20.0),
          )
        ],
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14.4746,
        ),
        markers: _markers,
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: color,
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
            icon: new Icon(
              Icons.search,
              color: color,
            ),
            title: new Text(
              "Recherche",
              style: TextStyle(color: color, fontSize: 11),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.navigation_sharp,
              color: color,
            ),
            title: new Text(
              "Mes incidents",
              style: TextStyle(color: color, fontSize: 13),
            ),
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
