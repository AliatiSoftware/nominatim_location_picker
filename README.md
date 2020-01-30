# Nominatim Location Picker 
[![Build Status](https://img.shields.io/badge/pub-0.0.1-orange)](https://travis-ci.org/joemccann/dillinger)


Nominatim Location Picker is a package that appears as a free alternative with support for Geocoding, using the OpenStreetMap API Using the OpenStreetMap API serving as a substitute for Google Maps and MapBox spatial search. However, there are some limitations regarding its use on a large scale project.
  

# Using the OpenStreetMap API Location Picker's version 0.0.1 new features!
----------------------
 - Geocoding search
 - Get Current User Location
 - Returns the Latitude and Longitude coordinates of the searched location 
 - Returns the description of the searched location
 - Returns the Country, State, city and district of the searched Location


 # OpenStreetMap Nominatim
----------------------

Nominatim (from the Latin, 'by name') is a tool to search OpenStreetMap data
by name and address (geocoding) and to generate synthetic addresses of
OSM points (reverse geocoding). An instance with up-to-date data can be found
at https://nominatim.openstreetmap.org. Nominatim is also used as one of the
sources for the Search box on the OpenStreetMap home page.

# Nominatim's Documentation
------------

The documentation of the latest development version is in the
`docs/` subdirectory. A HTML version can be found at
https://nominatim.org/release-docs/develop/ .

# Nominatim's Limitations

- No heavy uses (an absolute maximum of 1 request per second).
- Provide a valid HTTP Referer or User-Agent identifying the application (stock User-Agents as set by http libraries will not do).
- Clearly display attribution as suitable for your medium.
- Data is provided under the ODbL license which requires to share alike (although small extractions are likely to be covered by fair usage / fair dealing).

## Usage
-----------
To use this plugin, add `nominatim_location_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```dart
nominatim_location_picker ^0.0.1
```

Import the Nominatim Location Picker in your .dart file...

```dart
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
```

### Android Permissions 
-----------
The following permissions are recommended.

`android.permission.ACCESS_FINE_LOCATION` Allows the API to determine as precise a location as possible from the available location providers, including the Global Positioning System (GPS) as well as WiFi and mobile cell data.

`android.permission.ACCESS_COARSE_LOCATION` Allows the API to use WiFi or mobile cell data (or both) to determine the device's location. The API returns the location with an accuracy approximately equivalent to a city block.

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```


### Example

``` dart
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
  
  RaisedButton createButton(Color color, String name) {
    return RaisedButton(
      color: color,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NominatimLocationPicker()),
        );
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
      title: Text(widget.title),
    );
  }

  Widget body(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: createButton(Colors.green, 'Acess Nominatim Location Picker'),
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
```


#### Development Team 
----

| Team Members | Github | Email|
| ------ | ------ | ------ |
| Lucas Finoti | [https://github.com/FinotiLucas][LFGh] |lucas.finoti@protonmail.com|
| João Pedro Martins | [https://github.com/jpmdodev][JpGh] |jpmdo98@gmail.com|


### Credits 
----
Everything that we use as a reference to make this project possible

| Source | Web Sites |
| ------ | ------ |
| Nominatim  | [https://nominatim.org/release-docs/develop/][NNT] |
| Open Street Map | [https://www.openstreetmap.org][OSM] |
| Wikimedia Maps | [http://wikimapia.org/][WMM] |
| Google Maps Location Picker | [https://pub.dev/packages/google_map_location_picker][GMLP] 


### Development
----
Want to contribute? Great!
Code sharing makes the world a better place <3

### License
----

Apache License 2.0
[See more about the license][LICENSE]




[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)



   [LFGh]: <https://github.com/FinotiLucas>
   [JPGh]: <https://github.com/jpmdodev>
   [LICENSE]: <https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/LICENSE>
   [GMLP]: <https://pub.dev/packages/google_map_location_picker>
   [NNT]: <https://nominatim.org/release-docs/develop/>
   [OSM]: <https://www.openstreetmap.org>
   [WMM]: <http://wikimapia.org/>

