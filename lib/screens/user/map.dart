import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class Map extends StatefulWidget {
  double lat, long;
  Map({Key? key, required this.lat, required this.long}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex;
  Iterable markers = [];
  late CameraPosition _kLake;
  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.long),
      zoom: 14.4746,
    );
    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(widget.lat, widget.long),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    _goToLocationOnMap(widget.lat, widget.long);
  }

  Future<void> _goToLocationOnMap(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
//            bearing: 192.8334901395799,
          target: LatLng(widget.lat, widget.long),
          zoom: 16.151926040649414),
    ));

    Iterable _markers = Iterable.generate(1, (index) {
      LatLng latLngMarker = LatLng(latitude, longitude);

      return Marker(
        markerId: MarkerId("marker$index"),
        position: latLngMarker,
      );
    });

    setState(() {
      markers = _markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markers),
        onCameraMove: (position) {
          print(position);

          Iterable _markers = Iterable.generate(1, (index) {
            LatLng latLngMarker =
                LatLng(position.target.latitude, position.target.longitude);
            return Marker(
              markerId: MarkerId("marker$index"),
              position: latLngMarker,
            );
          });

          setState(() {
            widget.lat = position.target.latitude;
            widget.long = position.target.longitude;
            markers = _markers;
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop(LatLng(widget.lat, widget.long));
        },
        label: Text('Accept address'),
        icon: Icon(Icons.done),
      ),
    );
  }

  void accept() async {
    Navigator.of(context).pop(LatLng(widget.lat, widget.long));
  }
}
