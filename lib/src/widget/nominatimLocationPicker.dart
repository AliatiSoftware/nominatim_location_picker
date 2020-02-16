import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:nominatim_location_picker/src/loaders/loader_animator.dart';
import 'package:nominatim_location_picker/src/map/map.dart';
import 'package:nominatim_location_picker/src/services/nominatim.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NominatimLocationPicker extends StatefulWidget {
  NominatimLocationPicker({
    this.searchHint = 'Search',
    this.awaitingForLocation = "Awaiting for you current location"
  });

  final String searchHint;
  final String awaitingForLocation;

  @override
  _NominatimLocationPickerState createState() => _NominatimLocationPickerState();
}

class _NominatimLocationPickerState extends State<NominatimLocationPicker> {
  Map retorno;

  List _addresses = List();
  Color _color = Colors.black;
  TextEditingController _ctrlSearch = TextEditingController();
  Position _currentPosition;
  String _desc;
  bool _isSearching = false;
  double _lat;
  double _lng;
  MapController _mapController = MapController();
  List<Marker> _markers = [
    /*
    --- manage marker
  */
    Marker(
      width: 50.0,
      height: 50.0,
      point: new LatLng(0.0, 0.0),
      builder: (ctx) => new Container(
        child: Icon(
          Icons.location_on,
          size: 50.0,
        ),
      ),
    )
  ];

  LatLng _point;

  @override
  void dispose() {
    _ctrlSearch.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _changeAppBar() {
    /*
    --- manage appbar state
  */
    setState(() {
      _isSearching = !_isSearching;
    });
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
      _point = LatLng(_lat, _lng);
      _markers[0] = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        builder: (ctx) => new Container(
          child: Icon(
            Icons.location_on,
            size: 50.0,
            color: Colors.black,
          ),
        ),
      );
    });
  }

  _getCurrentLocationDesc() async {
    /*
    --- Função responsável por atualizar a descrição para a referente a localização atual do usuário
  */
    dynamic res = await NominatimService().getAddressLatLng(
        "${_currentPosition.latitude} ${_currentPosition.longitude}");
    setState(() {
      _addresses = res;
      _lat = _currentPosition.latitude;
      _lng = _currentPosition.longitude;
      _point = LatLng(_lat, _lng);
      retorno = {
        'latlng': _point,
        'state': _addresses[0]['state'],
        'desc':
            "${_addresses[0]['country']}, ${_addresses[0]['state']}, ${_addresses[0]['city']}, ${_addresses[0]['city_district']}, ${_addresses[0]['suburb']}"
      };
      _desc = _addresses[0]['description'];
    });
  }

  onWillpop() {
    /*
    --- Função responsável por controlar o retorno da página de pesquisas para a de buscas
  */
    setState(() {
      _isSearching = false;
    });
  }

  _buildAppbar(bool _isResult) {
    /*
    --- Widget responsável constução da appbar customizada . 
  */
    return new AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      primary: true,
      title: _buildTextField(_isResult),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: _color),
        onPressed: () {
          Navigator.of(context).pop();
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          setState(() {
            _isSearching = false;
          });
        },
      ),
    );
  }

  _buildTextField(bool _isResult) {
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
                child: TextFormField(
                    controller: _ctrlSearch,
                    decoration: InputDecoration(
                        hintText: widget.searchHint,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: _color),
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                _isResult == false
                    ? _changeAppBar()
                    : setState(() {
                        _isSearching = true;
                      });
                dynamic res =
                    await NominatimService().getAddressLatLng(_ctrlSearch.text);
                setState(() {
                  _addresses = res;
                });
              },
            ),
          ],
        ));
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
    );
  }

  Widget _buildBody(BuildContext context) {
    /*
    --- Widget responsável constução da página como um todo. 
  */
    return new Stack(
      children: <Widget>[
        mapContext(context),
        _isSearching ? Container() : _buildDescriptionCard(),
        _isSearching ? Container() : floatingActionButton(),
        _isSearching ? searchOptions() : Text(''),
      ],
    );
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
                          child: AutoSizeText(
                            _desc == null 
                            ? widget.awaitingForLocation 
                            : _desc,
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
                setState(() {
                  _point = LatLng(
                      _currentPosition.latitude, _currentPosition.longitude);
                });
                Navigator.pop(context, retorno);
              }),
        ),
      ),
    );
  }

  Widget searchOptions() {
    /*
    --- Widget responsável pela exibição tela de exibição de um conjunto de resultados da pesquisa. 
  */
    return new WillPopScope(
      onWillPop: () async => onWillpop(), //Bloquear o retorno
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
          color: Colors.transparent,
          child: ListView.builder(
            itemCount: _addresses.length,
            itemBuilder: (BuildContext ctx, int index) {
              return GestureDetector(
                child: _buildLocationCard(_addresses[index]['description']),
                onTap: () {
                  _mapController.move(
                      LatLng(double.parse(_addresses[index]['lat']),
                          double.parse(_addresses[index]['lng'])),
                      19);

                  setState(() {
                    _desc = _addresses[index][
                        'description']; /*"${_addresses[index]['country']}, ${_addresses[index]['state']}, ${_addresses[index]['city']}, ${_addresses[index]['city_district']}, ${_addresses[index]['suburb']}";*/
                    _isSearching = false;
                    _lat = double.parse(_addresses[index]['lat']);
                    _lng = double.parse(_addresses[index]['lat']);
                    retorno = {
                      'latlng': LatLng(_lat, _lng),
                      'state': _addresses[index]['state'],
                      'desc': _addresses[index][
                          'description'] /*"${_addresses[index]['country']}, ${_addresses[index]['state']}, ${_addresses[index]['city']}, ${_addresses[index]['city_district']}, ${_addresses[index]['suburb']}";*/
                    };
                    _markers[0] = Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(double.parse(_addresses[index]['lat']),
                          double.parse(_addresses[index]['lng'])),
                      builder: (ctx) => new Container(
                        child: Icon(
                          Icons.location_on,
                          size: 50.0,
                        ),
                      ),
                    );
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _buildLocationCard(String text) {
    /*
    --- Widget responsável constução individual dos resultados de uma pesquisa . 
  */
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              //color: Colors.white,
              elevation: 4,
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: AutoSizeText(
                    text,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ))),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppbar(_isSearching),
      body: _buildBody(context),
    );
  }
}
