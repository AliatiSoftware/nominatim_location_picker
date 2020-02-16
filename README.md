
# Nominatim Location Picker

  

[![pub package](https://img.shields.io/pub/v/nominatim_location_picker.svg)](https://pub.dartlang.org/packages/nominatim_location_picker) [![GitHub stars](https://img.shields.io/github/stars/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/stargazers) [![GitHub forks](https://img.shields.io/github/forks/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/network) [![GitHub license](https://img.shields.io/github/license/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/AliatiSoftware/nominatim_location_picker)](https://github.com/AliatiSoftware/nominatim_location_picker/issues)

Nominatim Location Picker is a package that appears as a **FREE** alternative (WITH NO API KEYS OR EVEN ACCESSTOKEN, NONE OF THEM ARE NECESSARY) with support for Geocoding with a beautiful and coherent interface using the OpenStreetMap Nominatim.

**In the current version, support for Mapbox has also been added**, with an interface in line with  Nominatim so you can choose which one to use or vary between the two of them.

  

# Nominatim Location Picker Screenshots

<p>

<img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/nominatim.gif?raw=true"  width=265/>

<img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/nominatim-01.png?raw=true"  width=265  />

<img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/nominatim-02.png?raw=true"  width=265  />

<img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/nominatim-03.png?raw=true"  width=265  />

</p>
  # MapBox Location Picker Screenshots
  
  <img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/mapbox.gif?raw=true"  width=265/>

<img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/mapbox-01.png?raw=true"  width=265  />

<img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/mapbox-02.png?raw=true"  width=265  />

<img  src="https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/exemple/assets/screenshot/mapbox-03.png?raw=true"  width=265  />

</p>
  

  

# Nominatim Location Picker's version 0.1.0 new features!


- Support with the same interface for MapBox;

- Auto search with MapBox

- Geocoding search with Nominatim and Mapbox;

- Get Current User Location;

- Returns the Latitude and Longitude coordinates of the searched location;

- Returns the description of the searched location;

- Returns the Country, State, city and district of the searched Location in both Nominatim and MapBox;

  
  

# OpenStreetMap Nominatim

  

Nominatim (from the Latin, 'by name') is a tool to search OpenStreetMap data

by name and address (geocoding) and to generate synthetic addresses of

OSM points (reverse geocoding). An instance with up-to-date data can be found

at https://nominatim.openstreetmap.org. Nominatim is also used as one of the

sources for the Search box on the OpenStreetMap home page.

  

# Nominatim's Documentation


  

The documentation of the latest development version is in the

`docs/` subdirectory. A HTML version can be found at

https://nominatim.org/release-docs/develop/ .

  

# Nominatim's Limitations

  

- No heavy uses (an absolute maximum of 1 request per second).

- Provide a valid HTTP Referer or User-Agent identifying the application (stock User-Agents as set by http libraries will not do).

- Clearly display attribution as suitable for your medium.

- Data is provided under the ODbL license which requires to share alike (although small extractions are likely to be covered by fair usage / fair dealing).

  

# MapBox

Mapbox is a large provider of custom online maps for websites and applications. Since 2010, it has rapidly expanded the niche of custom maps, as a response to the limited choice offered by map providers such as Google Maps.

  

# MapBox's Documentation

Mapbox APIs are divided into four distinct services: Maps, Navigation, Search, and Accounts. Each of these services has its own overview page in this documentation. These overview pages are divided into the individual APIs that make up the service. The documentation for each API is structured by endpoints. An endpoint is a specific method within an API that performs one action and is located at a specific URL

  

https://docs.mapbox.com/api/

  
  

## Usage


To use this plugin, add `nominatim_location_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

  

```yaml

dependencies:

nominatim_location_picker: ^0.1.0

```

Import the Nominatim Location Picker in your .dart file...

  

```dart

import  'package:nominatim_location_picker/nominatim_location_picker.dart';

```

  

### Android Permissions


The following permissions are recommended.

  

`android.permission.ACCESS_FINE_LOCATION` Allows the API to determine as precise a location as possible from the available location providers, including the Global Positioning System (GPS) as well as WiFi and mobile cell data.

  

`android.permission.ACCESS_COARSE_LOCATION` Allows the API to use WiFi or mobile cell data (or both) to determine the device's location. The API returns the location with an accuracy approximately equivalent to a city block.

  

```xml

<uses-permission  android:name="android.permission.ACCESS_FINE_LOCATION"  />

<uses-permission  android:name="android.permission.ACCESS_COARSE_LOCATION"  />

<uses-permission  android:name="android.permission.INTERNET"  />

```

  
  

### Example of Nominatim Location Picker

[See more in the main.dart file](https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/example/lib/main.dart).

  

``` dart

import  'package:nominatim_location_picker/nominatim_location_picker.dart'; 

  Future getLocationWithNominatim() async {
    Map result = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return NominatimLocationPicker(
            searchHint: 'Pesquisar',
            awaitingForLocation: "Procurando por sua localização",
          );
        });
    if (result != null) {
      setState(() => _pickedLocation = result);
    } else {
      return;
    }
  }
```

  

### Example of MapBox Location Picker

[See more in the main.dart file](https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/example/lib/main.dart).

  

``` dart

import  'package:nominatim_location_picker/nominatim_location_picker.dart';

  Widget getLocationWithMapBox() {
    return MapBoxPlaceSearchWidget(
      popOnSelect: true,
      apiKey: "YOUR API KEY",
      limit: 10,
      language: 'pt',
      country: 'br',
      searchHint: 'Pesquisar',
      awaitingForLocation: "Procurando por sua localização",
      onSelected: (place) {
        setState(() {
          _pickedLocationText = place.geometry.coordinates; // Example of how to call the coordinates after using the Mapbox Location Picker
          print(_pickedLocationText);
        });
      },
      context: context,
    );
  }
```

  
  

#### Aliati Software Development Team


  

| Team Members | Role | Github | Email|

| ------ | ------ | ------ | ------ |

| Lucas Finoti |CEO |[https://github.com/FinotiLucas][LFGh] |lucas.finoti@protonmail.com|

| João Pedro Martins |CTO |[https://github.com/jpmdodev][JpGh] |jpmdo98@gmail.com|

  
  

### Credits


Everything that we use as a reference to make this project possible

  

| Source | Web Sites |

| ------ | ------ |

| Nominatim | [https://nominatim.org/release-docs/develop/][NNT] |

| Open Street Map | [https://www.openstreetmap.org][OSM] |

| Wikimedia Maps | [http://wikimapia.org/][WMM] |

| Google Maps Location Picker | [https://pub.dev/packages/google_map_location_picker][GMLP]

| Mapbox Search | [https://pub.dev/packages/mapbox_search][MBS]

  
  

### Development


Want to contribute? Great!

Sharing Code makes the world a better place <3

  
  

### Support


  

Help us to continue developing solutions for the community

  

<center>

<a  href="https://www.buymeacoffee.com/6cdltqC"  target="_blank"><img  src="https://cdn.buymeacoffee.com/buttons/default-blue.png"  alt="Buy Me A Coffee"  style="height: 51px !important;width: 217px !important;"  ></a>

</center>

  
  

### License


  

Apache License 2.0

  

Copyright (c) 2020 Aliati Sotware, Lucas Finoti and João Pedro Martins

  

[See more about the license][LICENSE]

  

[LFGh]: <https://github.com/FinotiLucas>

[JPGh]: <https://github.com/jpmdodev>

[LICENSE]: <https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/LICENSE>

[GMLP]: <https://pub.dev/packages/google_map_location_picker>

[MBS]: <https://pub.dev/packages/mapbox_search>

[NNT]: <https://nominatim.org/release-docs/develop/>

[OSM]: <https://www.openstreetmap.org>

[WMM]: <http://wikimapia.org/>
