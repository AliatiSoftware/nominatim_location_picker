# Nominatim Location Picker 

[![pub package](https://img.shields.io/pub/v/nominatim_location_picker.svg)](https://pub.dartlang.org/packages/nominatim_location_picker) [![GitHub stars](https://img.shields.io/github/stars/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/stargazers) [![GitHub forks](https://img.shields.io/github/forks/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/network)  [![GitHub license](https://img.shields.io/github/license/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/LICENSE)  [![GitHub issues](https://img.shields.io/github/issues/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/issues) 
Nominatim Location Picker is a package that appears as a **FREE** alternative (WITH NO API KEYS OR EVEN ACCESSTOKEN, NONE OF THEM ARE NECESSARY) with support for Geocoding, using the OpenStreetMap Nominatim service serving as a substitute for Google Maps and MapBox spatial search. However, there are some limitations (All of the conditions for using Nominatim are well explained further in this documentation) regarding its use on a large scale project.

We highly recommend the use of the package in small and medium projects due to the limitations that OpenStreetMap servers have, or as a way of reducing costs in large projects, varying between the map providers of your preference and our package.

  

# Nominatim Location Picker's version 0.0.1 new features!
----------------------
 - Geocoding search;
 - Get Current User Location;
 - Returns the Latitude and Longitude coordinates of the searched location;
 - Returns the description of the searched location;
 - Returns the Country, State, city and district of the searched Location;
 - Use your own custom Maps and Markers.


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

```yaml
dependencies:
  nominatim_location_picker: ^0.0.1
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


#### AliatiSoftware Development Team 
----

| Team Members | Role | Github | Email|
| ------ | ------ | ------ | ------ |
| Lucas Finoti |CEO |[https://github.com/FinotiLucas][LFGh] |lucas.finoti@protonmail.com|
| João Pedro Martins |CTO |[https://github.com/jpmdodev][JpGh] |jpmdo98@gmail.com|


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
Sharing Code makes the world a better place <3


### Support
----

Help us to continue developing solutions for the community 

<center>
<a href="https://www.buymeacoffee.com/6cdltqC" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-blue.png" alt="Buy Me A Coffee" style="height: 51px !important;width: 217px !important;" ></a>
</center>


### License
----

Apache License 2.0
[See more about the license][LICENSE]



   [LFGh]: <https://github.com/FinotiLucas>
   [JPGh]: <https://github.com/jpmdodev>
   [LICENSE]: <https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/LICENSE>
   [GMLP]: <https://pub.dev/packages/google_map_location_picker>
   [NNT]: <https://nominatim.org/release-docs/develop/>
   [OSM]: <https://www.openstreetmap.org>
   [WMM]: <http://wikimapia.org/>

