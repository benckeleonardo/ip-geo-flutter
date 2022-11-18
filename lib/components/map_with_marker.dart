import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithMarker extends StatefulWidget {
  @override
  State<MapWithMarker> createState() => MapWithMarkerState();

  MapWithMarker(this._lat, this._lon);

  double? _lat;
  double? _lon;
}

class MapWithMarkerState extends State<MapWithMarker> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> markers = Set();
  final Set<Circle> circles = Set();

  @override
  Widget build(BuildContext context) {
    double? lat = widget._lat;
    double? lon = widget._lon;

    if (lat != null && lon != null) {
      _goToPosition(lat, lon);
    }

    return GoogleMap(
      markers: markers,
      circles: circles,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 10,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> _goToPosition(lat, lon) async {
    markers.add(Marker(
      markerId: MarkerId('IP Marker'),
      position: LatLng(lat, lon),
      infoWindow: InfoWindow(
        title: 'IP Location',
        snippet: '',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    circles.add(
      Circle(
        circleId: CircleId('IP Circle'),
        center: LatLng(lat, lon),
        radius: 600,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeWidth: 0,
      )
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lon),
          zoom: 14.4746,
        ),
      ),
    );
  }
}
