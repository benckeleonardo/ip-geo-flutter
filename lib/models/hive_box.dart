import 'package:hive/hive.dart';
import 'package:ip_geo_flutter/models/ip_geolocation.dart';

class HiveBox {
  static void start() async {
      final collection = await BoxCollection.open(
      'MyFirstFluffyBox', // Name of your database
      {'ip_history'}, // Names of your boxes
      path: './', // Path where to store your boxes (Only used in Flutter / Dart IO) // Key to encrypt your boxes (Only used in Flutter / Dart IO)
    );
    final box = collection.openBox<IPGeolocation>('ip_history');
  }
}