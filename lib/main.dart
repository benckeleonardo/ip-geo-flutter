import 'package:flutter/material.dart';
import 'package:ip_geo_flutter/components/bottom_nav_bar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BottomNavBar(),
    );
  }
}