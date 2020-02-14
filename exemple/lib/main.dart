import 'package:flutter/material.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorBrightness: Brightness.dark
      ),
      home: MyHomePage(title: 'Nominatim Location Picker Exemple'),
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

  Map _pickedLocation;
  bool hasLocation = false;

  Future getLocation() async {
    Map result = await showDialog(
      context: context,
      builder: (BuildContext ctx){
        return NominatimLocationPicker();
      }
    );
    if(result != null){
      setState(() => _pickedLocation = result);
      setState(() => hasLocation = true);
    }
    else{
      return;
    }
  }
  
  
  RaisedButton createButton(Color color, String name) {

    return RaisedButton(
      color: color,
      onPressed: () async {
        await getLocation();
      },
      textColor: Colors.white,
      child: Center(
        child: Text(name),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  Widget appBar(){
    return AppBar(
      title: Text('Nominatim Location Picker Exemple'),
    );
  }

  Widget body(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: hasLocation ? Center(child:  Text("$_pickedLocation")) : createButton(Colors.green, 'Acess Nominatim Location Picker'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: appBar(),
      body: body(context)
    );
  }
}
