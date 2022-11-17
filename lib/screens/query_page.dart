import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/info_container.dart';
import '../components/map_sample.dart';
import '../models/ip_geolocation.dart';

class QueryPage extends StatefulWidget {
  IPGeolocation? _ipInfo;

  @override
  State<StatefulWidget> createState() {
    return QueryPageState();
  }
}

class QueryPageState extends State<QueryPage> {
  void _updateIpInfo(IPGeolocation ipInfo) {
    setState(() {
      widget._ipInfo = ipInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: InputWithIcon(_updateIpInfo),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 300,
            width: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              child: Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 0.3,
                  widthFactor: 2.5,
                  child: MapSample(widget._ipInfo?.lat, widget._ipInfo?.lon)),
            ),
          ),
          Text(
            '*What you are seeing here is the Approximate Location and it might differ slightly, Thanks.',
          ),
          InfoContainer(widget._ipInfo),
        ],
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
              decoration: InputDecoration.collapsed(hintText: 'A Public IP Address'),
              controller: ipAddressController,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              FocusScopeNode currentFocus = FocusScope.of(context);
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

Future<IPGeolocation> fetchIPGeolocation(String ipAddress) async {
  String url = 'http://ip-api.com/json/$ipAddress';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return IPGeolocation.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load IPGeolocation');
}

