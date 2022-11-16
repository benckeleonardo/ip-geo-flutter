import 'package:flutter/material.dart';
import '../models/ip_geolocation.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer(this._data);

  final IPGeolocation? _data;

  @override
  Widget build(BuildContext context) {
    if (_data == null) return Container();

    final styleKey = TextStyle(
      color: Colors.blue,
      fontSize: 20,
    );

    final styleValue = TextStyle(
      fontSize: 20,
    );

    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' Query:   ', style: styleKey),
                  Text('${_data?.query}',style: styleValue),
                ],
              ),
            ),
          ), 
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' Country:   ', style: styleKey),
                  Text('${_data?.country} (${_data?.countryCode})',style: styleValue),
                ],
              ),
            ),
          ), 
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' Region:   ', style: styleKey),
                  Text('${_data?.regionName} (${_data?.region})', style: styleValue),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' City:   ', style: styleKey),
                  Text('${_data?.city}', style: styleValue),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' Zip code:   ', style: styleKey),
                  Text('${_data?.zip}', style: styleValue),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' Timezone:   ', style: styleKey),
                  Text('${_data?.timezone}', style: styleValue),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' ISP:   ', style: styleKey),
                  Text('${_data?.isp}', style: styleValue),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' Organization:   ', style: styleKey),
                  Flexible(child: Text('${_data?.org}', style: styleValue)),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Text(' AS:   ', style: styleKey),
                  Flexible(child: Text('${_data?.as}', style: styleValue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
