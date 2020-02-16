import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  MapPage(
      {Key key,
      @required this.lat,
      @required this.lng,
      @required this.mapController,
      @required this.markers,
      this.isNominatim = true,
      this.apiKey})
      : super(key: key);
  final List<Marker> markers;
  final double lat;
  final double lng;
  final MapController mapController;
  final bool isNominatim;
  final String apiKey;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Widget body(BuildContext context) {
    return new FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        center: LatLng(widget.lat, widget.lng),
        zoom: 13.0,
      ),
      layers: [
        widget.isNominatim
            ? new TileLayerOptions(
                urlTemplate:
                    'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'])
            : new TileLayerOptions(
                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken': widget.apiKey,
                  'id': 'mapbox.streets',
                },
              ),
        MarkerLayerOptions(
          markers: widget.markers,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }
}
