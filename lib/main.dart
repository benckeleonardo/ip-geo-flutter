import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ip_geo_flutter/controllers/ip_geolocation_controller.dart';
import 'package:ip_geo_flutter/models/ip_geolocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrincipalPage(),
    );
  }
}

class PrincipalPage extends StatefulWidget {
  IPGeolocation? _ipInfo;

  @override
  State<StatefulWidget> createState() {
    return PrincipalPageState();
  }
}

class PrincipalPageState extends State<PrincipalPage> {
  void _updateIpInfo(IPGeolocation ipInfo) {
    setState(() {
      widget._ipInfo = ipInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IP Tools',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            InputWithIcon(_updateIpInfo),
            Container(
              height: 300,
              width: 300,
              child: MapSample(widget._ipInfo?.lat, widget._ipInfo?.lon),
            ),
            Text(
                '*What you are seeing here is the Approximate Location and it might differ slightly, Thanks.'),
            InfoContainer(widget._ipInfo),
          ],
        ),
      ),
    );
  }
}

class InputWithIcon extends StatelessWidget {
  InputWithIcon(this.refresh);

  Function refresh;
  final TextEditingController ipAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: ipAddressController,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String ipAddress = ipAddressController.text;
              IPGeolocation ipInfo = await fetchIPGeolocation(ipAddress);
              refresh(ipInfo);
            },
          ),
        ],
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer(this._data);

  final IPGeolocation? _data;

  @override
  Widget build(BuildContext context) {
    if (_data == null) return Container();

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Country code:',
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                '${_data?.countryCode}',
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Country name:',
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                '${_data?.country}',
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Region:',
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                '${_data?.region}',
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'City:',
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                '${_data?.city}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
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
