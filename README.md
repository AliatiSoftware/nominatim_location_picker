# Nominatim Location Picker



[![Build Status](https://img.shields.io/badge/pub-0.0.1-orange)](https://travis-ci.org/joemccann/dillinger)

Dillinger is a cloud-enabled, mobile-ready, offline-storage, AngularJS powered HTML5 Markdown editor.

  - Type some Markdown on the left
  - See HTML in the right
  - Magic

# Nominatim Location Picker's Features!

  - Import a HTML file and watch it magically convert to Markdown
  - Drag and drop images (requires your Dropbox account be linked)


You can also:
  - Import and save files from GitHub, Dropbox, Google Drive and One Drive
  - Drag and drop markdown and HTML files into Dillinger
  - Export documents as Markdown, HTML and PDF

Markdown is a lightweight markup language based on the formatting conventions that people naturally use in email.  As [John Gruber] writes on the [Markdown site][df1]

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually* written in Markdown! To get a feel for Markdown's syntax, type some text into the left window and watch the results in the right.


And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

## Usage
To use this plugin, add `nominatim_location_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```dart
nominatim_location_picker ^0.0.1
```

Import the Nominatim Location Picker in your .dart file...

```dart
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
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
| Joáo Pedro Martins | [https://github.com/jpmdodev][JpGh] |jpm|


### Credits 
----
Dillinger is currently extended with the following plugins. Instructions on how to use them in your own application are linked below.

| Plugin | Web Sites |
| ------ | ------ |
| Nominatim  | [plugins/dropbox/README.md][PlDb] |
| Open Street Map | [plugins/github/README.md][PlGh] |
| Wikimedia Maps | [plugins/googledrive/README.md][PlGd] |
| Google Maps Location Picker | [plugins/googledrive/README.md][PlGd] 


### Development
----
Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantaneously see your updates!

### License
----

MIT


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [LFGh]: <https://github.com/FinotiLucas>
   [JPGh]: <https://github.com/jpmdodev>
   
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
