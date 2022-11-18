import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class IPGeolocation extends HiveObject {
  IPGeolocation({
    required this.status,
    required this.continent,
    required this.continentCode,
    required this.country, 
    required this.countryCode, 
    required this.region, 
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.isp,
    required this.org,
    required this.as,
    required this.query
  });
  
  @HiveField(0)
  final String status;
  @HiveField(1)
  final String continent;
  @HiveField(2)
  final String continentCode;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String countryCode;
  @HiveField(5)
  final String region;
  @HiveField(6)
  final String regionName;
  @HiveField(7)
  final String city;
  @HiveField(8)
  final String zip;
  @HiveField(9)
  final double lat;
  @HiveField(10)
  final double lon;
  @HiveField(11)
  final String timezone;
  @HiveField(12)
  final String isp;
  @HiveField(13)
  final String org;
  @HiveField(14)
  final String as;
  @HiveField(15)
  final String query;

  factory IPGeolocation.fromJson(Map<String, dynamic> json) {
    return IPGeolocation(
      status: json['status'],
      continent: json['continent'],
      continentCode: json['continentCode'],
      country: json['country'],
      countryCode: json['countryCode'],
      region: json['region'],
      regionName: json['regionName'],
      city: json['city'],
      zip: json['zip'],
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      isp: json['isp'],
      org: json['org'],
      as: json['as'],
      query: json['query']
    );
  }
}