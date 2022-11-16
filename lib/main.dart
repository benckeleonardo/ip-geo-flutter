import 'package:flutter/material.dart';
import 'package:ip_geo_flutter/screens/principal_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrincipalPage(),
    );
  }
}
