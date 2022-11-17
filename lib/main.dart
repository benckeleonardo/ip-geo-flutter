import 'package:flutter/material.dart';
import 'package:ip_geo_flutter/components/app_nav_bar.dart';
import 'package:ip_geo_flutter/screens/query_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppNavBar(),
    );
  }
}
