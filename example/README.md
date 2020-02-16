# nominatim_location_picker_exemple

How to use the nominatim_location_picker

## Usage


To use this plugin, add `nominatim_location_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

  

```yaml

dependencies:

nominatim_location_picker: any # or the latest version on Pub

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


### Nominatim Location Picker with Custom Maps and Markers

[See more in the main.dart file](https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/example/lib/main.dart).

  

``` dart

import  'package:nominatim_location_picker/nominatim_location_picker.dart'; 
import 'package:flutter_map/flutter_map.dart';

  Future getLocationWithNominatim() async {
    Map result = await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return NominatimLocationPicker(
          searchHint: 'Pesquisar',
          awaitingForLocation: "Procurando por sua localização",
          customMarkerIcon: Image.asset(
            "assets/marker.png",
          ),
          customMapLayer: TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
          ),
        );
      }
    );
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
    return MapBoxLocationPicker(
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

### MapBox Location Picker with Custom Maps and Markers

[See more in the main.dart file](https://github.com/AliatiSoftware/nominatim_location_picker/blob/master/example/lib/main.dart).

  

``` dart

import  'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:flutter_map/flutter_map.dart';

  Widget getLocationWithMapBox() {
    return MapBoxLocationPicker(
      popOnSelect: true,
      apiKey: "pk.eyJ1IjoiYWxpYXRpc29mdHdhcmUiLCJhIjoiY2s2bWFiZDZ3MG56ODNkcWZjbWRkMDBncSJ9.pQ9-4cgNJThcp1Q3PILAcg",
      //apiKey: "YOUR API KEY",
      limit: 10,
      language: 'pt',
      country: 'br',
      searchHint: 'Pesquisar',
      awaitingForLocation: "Procurando por sua localização",
      
      customMarkerIcon: Image.asset(
        "assets/marker.png",
      ),

      customMapLayer: TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']
      ),

      onSelected: (place) {
        setState(() {
          _pickedLocationText = place.geometry
              .coordinates; // Example of how to call the coordinates after using the Mapbox Location Picker
          print(_pickedLocationText);
        });
      },
      context: context,
    );
  }
```