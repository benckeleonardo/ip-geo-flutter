import 'package:flutter/material.dart';
import 'package:ip_geo_flutter/components/bottom_nav_bar.dart';

import 'models/hive_config.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BottomNavBar(),
    );
  }
}