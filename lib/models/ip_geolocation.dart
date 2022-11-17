class IPGeolocation {
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
  
  final String status;
  final String continent;
  final String continentCode;
  final String country;
  final String countryCode;
  final String region;
  final String regionName;
  final String city;
  final String zip;
  final double lat;
  final double lon;
  final String timezone;
  final String isp;
  final String org;
  final String as;
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