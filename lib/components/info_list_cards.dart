import 'package:flutter/material.dart';
import '../models/ip_geolocation.dart';

class InfoListCards extends StatelessWidget {
  const InfoListCards(this._data);

  final IPGeolocation? _data;

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      return Container(
        height: 200,
        child: Center(
          child: Text('Make a query to fetch geolocation information'),
        ),
      );
    }

    final styleKey = TextStyle(color: Colors.blue, fontSize: 16);
    final styleValue = TextStyle(fontSize: 16);

    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text('Query results for ${_data?.query}'),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Continent', style: styleKey),
                    Text('${_data?.continent} (${_data?.continentCode})',
                        style: styleValue),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Country', style: styleKey),
                    Text('${_data?.country} (${_data?.countryCode})',
                        style: styleValue),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Region', style: styleKey),
                    Text('${_data?.regionName} (${_data?.region})',
                        style: styleValue),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('City', style: styleKey),
                    Text('${_data?.city}', style: styleValue),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Zipcode', style: styleKey),
                    Text('${_data?.zip}', style: styleValue),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Timezone', style: styleKey),
                    Text('${_data?.timezone}', style: styleValue),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ISP', style: styleKey),
                    Text('${_data?.isp}', style: styleValue),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Organization', style: styleKey),
                    Flexible(child: Text('${_data?.org}', style: styleValue)),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('AS', style: styleKey),
                    Flexible(child: Text('${_data?.as}', style: styleValue)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
