import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/info_list_cards.dart';
import '../components/map_with_marker.dart';
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
      primary: false,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: InputWithIcon(_updateIpInfo),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 300,
            width: 300,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              child: Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 0.3,
                  widthFactor: 2.5,
                  child: MapWithMarker(widget._ipInfo?.lat, widget._ipInfo?.lon)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2, left: 50, right: 50),
            child: Text(
              '*What you are seeing here is the Approximate Location and it might differ slightly, Thanks.',
              style: TextStyle(fontSize: 12),
            ),
          ),
          InfoListCards(widget._ipInfo),
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: ipAddressController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a public IP address',
                contentPadding: EdgeInsets.only(left: 20),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (text) async {
                IPGeolocation ipInfo;
                String ipAddress = text;
                //Testando se é IP público
                if (!validatePublicIPAddress(ipAddress)) {
                  showMessage(context,
                      'A public network IPV4 address is required to perform the query.');
                  return;
                }

                //Se a consulta não puder ser realizada
                try {
                  ipInfo = await fetchIPGeolocation(ipAddress);
                } catch (e) {
                  showMessage(context,
                      'Query cannot be performed. Check your internet connection.');
                  return;
                }

                //testando se a consulta foi realizada com sucesso
                if (ipInfo.status == 'fail') {
                  showMessage(
                      context, 'Query cannot be performed successfully');
                  return;
                }

                // Se não houve nada de errado, mostrar as informações
                refresh(ipInfo);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              IPGeolocation ipInfo;
              String ipAddress = ipAddressController.text;
              //Testando se é IP público
              if (!validatePublicIPAddress(ipAddress)) {
                showMessage(context,
                    'A public network IPV4 address is required to perform the query.');
                return;
              }

              //Se a consulta não puder ser realizada
              try {
                ipInfo = await fetchIPGeolocation(ipAddress);
              } catch (e) {
                showMessage(context,
                    'Query cannot be performed. Check your internet connection.');
                return;
              }

              //testando se a consulta foi realizada com sucesso
              if (ipInfo.status == 'fail') {
                showMessage(context, 'Query cannot be performed successfully');
                return;
              }

              // Se não houve nada de errado, mostrar as informações
              refresh(ipInfo);
            },
          ),
        ],
      ),
    );
  }
}

bool validatePublicIPAddress(String ipAddress) {
  final regex = RegExp(
      r"^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(?<!172\.(16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31))(?<!127)(?<!^10)(?<!^0)\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(?<!192\.168)(?<!172\.(16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31))\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$");
  return regex.hasMatch(ipAddress);
}

bool validateAnyIPAddress(String ipAddress) {
  final regex = RegExp(r"^\d{1,3}[.]\d{1,3}[.]\d{1,3}[.]\d{1,3}$");
  return regex.hasMatch(ipAddress);
}

Future<IPGeolocation> fetchIPGeolocation(String ipAddress) async {
  String url =
      'http://ip-api.com/json/$ipAddress?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,query';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return IPGeolocation.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load IPGeolocation');
}

Future<void> showMessage(context, message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Information'),
        content: SingleChildScrollView(
          child: Text('$message'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
