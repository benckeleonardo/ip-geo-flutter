import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();

  MapSample(this._lat, this._lon);

  double? _lat;
  double? _lon;
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    double? lat = widget._lat;
    double? lon = widget._lon;

    if (lat != null && lon != null) {
      _goToPosition(lat, lon);
    }

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 11,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> _goToPosition(lat, lon) async {
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