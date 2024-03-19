class RealtimeWeatherDataModel {
  Data data;
  Location location;

  RealtimeWeatherDataModel({
    required this.data,
    required this.location,
  });

  factory RealtimeWeatherDataModel.fromJson(Map<String, dynamic> json) =>
      RealtimeWeatherDataModel(
        data: Data.fromJson(json["data"]),
        location: Location.fromJson(json["location"]),
      );
}

class Data {
  DateTime time;
  Values values;

  Data({
    required this.time,
    required this.values,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        time: DateTime.parse(json["time"]),
        values: Values.fromJson(json["values"]),
      );
}

class Location {
  double lat;
  double lon;
  String? name;
  String? type;

  Location({
    required this.lat,
    required this.lon,
    required this.name,
    required this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        name: json["name"],
        type: json["type"],
      );
}

class Values {
  final double humidity;
  final double temperatureApparent;
  final int weatherCode;
  final double windSpeed;

  Values({
    required this.humidity,
    required this.temperatureApparent,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(
      humidity: json['humidity'] == null ? 0 : json['humidity'].toDouble(),
      temperatureApparent: json['temperatureApparent'] == null
          ? 0
          : json['temperatureApparent'].toDouble(),
      weatherCode: json['weatherCode'] == null ? 0 : json['weatherCode'] ?? 0,
      windSpeed: json['windSpeed'] == null ? 0 : json['windSpeed'].toDouble(),
    );
  }
}
