import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ip_geo_flutter/models/ip_geolocation.dart';

Future<IPGeolocation> fetchIPGeolocation(String ipAddress) async {
    String url = 'http://ip-api.com/json/$ipAddress';
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      return IPGeolocation.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load IPGeolocation');
  }