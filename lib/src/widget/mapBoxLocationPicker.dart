import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:nominatim_location_picker/src/loaders/loader_animator.dart';
import 'package:nominatim_location_picker/src/widget/location.dart';
import 'package:nominatim_location_picker/src/widget/places_search.dart';
import 'package:nominatim_location_picker/src/widget/predictions.dart';
import 'package:nominatim_location_picker/src/services/nominatim.dart';

class MapBoxLocationPicker extends StatefulWidget {
  MapBoxLocationPicker({
    @required this.apiKey,
    this.onSelected,
    // this.onSearch,
    this.searchHint = 'Search',
    this.language = 'en',
    this.location,
    this.limit = 5,
    this.country,
    this.context,
    this.height,
    this.popOnSelect = false,
    this.awaitingForLocation = "Awaiting for you current location",
    this.customMarkerIcon,
    this.customMapLayer,
  });

  //
  final TileLayerOptions customMapLayer;

  //
  final Widget customMarkerIcon;

  /// API Key of the MapBox.
  final String apiKey;

  final String country;

  /// Height of whole search widget
  final double height;

  final String language;

  /// Limits the no of predections it shows
  final int limit;

  /// The point around which you wish to retrieve place information.
  final Location location;

  /// Language used for the autocompletion.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API

  ///Limits the search to the given country
  ///
  /// Check the full list of [supported countries](https://docs.mapbox.com/api/search/) for the MapBox API

  /// True if there is different search screen and you want to pop screen on select
  final bool popOnSelect;

  ///Search Hint Localization
  final String searchHint;

  /// Waiting For Location Hint text
  final String awaitingForLocation;

  @override
  _MapBoxLocationPickerState createState() => _MapBoxLocationPickerState();

  ///To get the height of the page
  final BuildContext context;

  /// The callback that is called when one Place is selected by the user.
  final void Function(MapBoxPlace place) onSelected;

  /// The callback that is called when the user taps on the search icon.
  // final void Function(MapBoxPlaces place) onSearch;
}

class _MapBoxLocationPickerState extends State<MapBoxLocationPicker>
    with SingleTickerProviderStateMixin {
  var reverseGeoCoding;

  List _addresses = List();
  AnimationController _animationController;
  // SearchContainer height.
  Animation _containerHeight;

  Position _currentPosition;
  Timer _debounceTimer;
  String _desc;
  double _lat;
  // Place options opacity.
  Animation _listOpacity;

  double _lng;
  MapController _mapController = MapController();

  List<Marker> _markers;

  MapBoxPlace _prediction;

  List<MapBoxPlace> _placePredictions = [];
  // MapBoxPlace _selectedPlace;
  var _selectedPlace;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _debounceTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _containerHeight =
        Tween<double>(begin: 73, end: MediaQuery.of(widget.context).size.height)
            .animate(
      CurvedAnimation(
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
        parent: _animationController,
      ),
    );
    _listOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
        parent: _animationController,
      ),
    );
    _getCurrentLocation();

    _markers = [
      /*
      --- manage marker
    */
      Marker(
        width: 50.0,
        height: 50.0,
        point: new LatLng(0.0, 0.0),
        builder: (ctx) => new Container(
            child: widget.customMarkerIcon == null
                ? Icon(
                    Icons.location_on,
                    size: 50.0,
                  )
                : widget.customMarkerIcon),
      )
    ];

    super.initState();
  }

  _getCurrentLocation() {
    /*
    --- Função responsável por receber a localização atual do usuário
  */
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getCurrentLocationMarker();
        _getCurrentLocationDesc();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getCurrentLocationMarker() {
    /*
    --- Função responsável por atualizar o marcador para a localização atual do usuário
  */
    setState(() {
      _lat = _currentPosition.latitude;
      _lng = _currentPosition.longitude;
      _markers[0] = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_lat, _lng),
        builder: (ctx) => new Container(
            child: widget.customMarkerIcon == null
                ? Icon(
                    Icons.location_on,
                    size: 50.0,
                  )
                : widget.customMarkerIcon),
      );
    });
  }

  _getCurrentLocationDesc() async {
    /*
    --- Função responsável por atualizar a descrição para a referente a localização atual do usuário com base no Nominatim para evitar o reverse Geocoding
  */
    dynamic res = await NominatimService().getAddressLatLng(
        "${_currentPosition.latitude} ${_currentPosition.longitude}");
    setState(() {
      _addresses = res;
      _lat = _currentPosition.latitude;
      _lng = _currentPosition.longitude;
      _desc = _addresses[0]['description'];
    });
  }

  // Widgets
  Widget _searchContainer({Widget child}) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Container(
            height: _containerHeight.value,
            decoration: _containerDecoration(),
            padding: EdgeInsets.only(left: 0, right: 0, top: 15),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: child,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Opacity(
                    opacity: _listOpacity.value,
                    child: ListView(
                      // addSemanticIndexes: true,
                      // itemExtent: 10,
                      children: <Widget>[
                        for (var places in _placePredictions)
                          _placeOption(places),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildAppbar() {
    /*
    --- Widget responsável constução da appbar customizada . 
  */
    return new AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      primary: true,
      title: _buildTextField(),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
        ),
        onPressed: () {
          Navigator.of(context).pop();
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
      ),
    );
  }

  _buildTextField() {
    /*
    --- Responsável constução do textfield de pesquisa . 
  */
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      hintText: widget.searchHint,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (value) {
                    _debounceTimer?.cancel();
                    _debounceTimer = Timer(Duration(milliseconds: 750), () {
                      if (mounted) {
                        setState(() => _autocompletePlace(value));
                      }
                    });
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                _textEditingController.text == "" ? Icons.search : Icons.close,
                color: Colors.black87,
              ),
              onPressed: () {
                if (_textEditingController.text == "") {
                  return null;
                } else {
                  setState(() {
                    _textEditingController.text = "";
                  });
                }
              },
            ),
          ],
        ));
  }

  Widget _buildDescriptionCard() {
    /*
    --- Widget responsável constução das descrições de um determinado local. 
  */
    return new Positioned(
      bottom: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.all(15),
                        child: Center(
                            child: Scrollbar(
                                child: new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: false,
                          child: Text(
                            _desc == null ? widget.awaitingForLocation : _desc,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                        )))),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  floatingActionButton() {
    /*
    --- Widget responsável pelo envio das coordenadas LatLong para serem utilizadas por terceiros . 
  */
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return new Positioned(
      bottom: -width * 0.025 + height * 0.075,
      right: width * 0.1,
      child: Container(
        height: width * 0.15,
        width: width * 0.15,
        child: FittedBox(
          child: FloatingActionButton(
              child: Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
                if (_prediction != null) {
                  widget.onSelected(_prediction);
                }
              }),
        ),
      ),
    );
  }

  Widget _placeOption(MapBoxPlace prediction) {
    String place = prediction.text;
    String fullName = prediction.placeName;

    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      onPressed: () {
        setState(() {
          _selectPlace(prediction);
        });
      },
      child: ListTile(
        title: Text(
          place.length < 45
              ? "$place"
              : "${place.replaceRange(45, place.length, "")} ...",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          maxLines: 1,
        ),
        subtitle: Text(
          fullName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          maxLines: 1,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),
      ),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: _textEditingController.text == "" ||
              _textEditingController.text == _selectedPlace.toString()
          ? Colors.transparent
          : Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    );
  }

  // Methods
  void _autocompletePlace(String input) async {
    /// Will be called when the input changes. Making callbacks to the Places
    /// Api and giving the user Place options
    ///
    if (input.length > 0) {
      var placesSearch = PlacesSearch(
        apiKey: widget.apiKey,
        country: widget.country,
      );

      final predictions = await placesSearch.getPlaces(
        input,
        location: widget.location,
      );

      await _animationController.animateTo(0.5);

      setState(() => _placePredictions = predictions);

      await _animationController.forward();
    } else {
      await _animationController.animateTo(0.5);
      setState(() => _placePredictions = []);
      await _animationController.reverse();
    }
  }

  void _selectPlace(MapBoxPlace prediction) async {
    /// Will be called when a user selects one of the Place options.

    // Sets TextField value to be the location selected
    _textEditingController.value = TextEditingValue(
      text: prediction.placeName,
      selection: TextSelection.collapsed(offset: prediction.placeName.length),
    );

    // Makes animation
    await _animationController.animateTo(0.5);
    setState(() {
      _placePredictions = [];
      _selectedPlace = prediction.placeName;
      _desc = _selectedPlace;
      _prediction = prediction;

      moveMarker(prediction);
    });
    _mapController.move(LatLng(_lat, _lng), 13);

    _animationController.reverse();

    // Calls the `onSelected` callback

    //if (widget.popOnSelect) Navigator.pop(context);
  }

  void moveMarker(MapBoxPlace prediction) {
    setState(() {
      _lat = prediction.geometry.coordinates.elementAt(1);
      _lng = prediction.geometry.coordinates.elementAt(0);

      _markers[0] = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_lat, _lng),
        builder: (ctx) => new Container(
            child: widget.customMarkerIcon == null
                ? Icon(
                    Icons.location_on,
                    size: 50.0,
                  )
                : widget.customMarkerIcon),
      );
    });
  }

  Widget mapContext(BuildContext context) {
    /*
    --- Widget responsável pela representação cartográfica da região, assim como seu ponto no espaço. 
  */

    while (_currentPosition == null) {
      return new Center(
        child: Loading(),
      );
    }

    return new MapPage(
        lat: _lat,
        lng: _lng,
        mapController: _mapController,
        markers: _markers,
        isNominatim: false,
        apiKey: widget.apiKey,
        customMapLayer: widget.customMapLayer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppbar(),
        body: Stack(
          children: <Widget>[
            mapContext(context),
            _buildDescriptionCard(),
            floatingActionButton(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width,
              child: _searchContainer(
                  //child: mapContext(context)
                  ),
            ),
          ],
        ));
  }
}
