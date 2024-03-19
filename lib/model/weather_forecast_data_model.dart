import 'dart:convert';

import 'realtime_weather.data_model.dart';

class WeatherForecastDataModel {
  Timelines timelines;
  Location location;

  WeatherForecastDataModel({
    required this.timelines,
    required this.location,
  });

  factory WeatherForecastDataModel.fromJson(Map<String, dynamic> json) =>
      WeatherForecastDataModel(
        timelines: Timelines.fromJson(json["timelines"]),
        location: Location.fromJson(json["location"]),
      );
}

class Timelines {
  List<Hourly> hourly;
  List<Daily> daily;

  Timelines({
    required this.hourly,
    required this.daily,
  });

  factory Timelines.fromJson(Map<String, dynamic> json) => Timelines(
        hourly:
            List<Hourly>.from(json["hourly"].map((x) => Hourly.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );
}

class Daily {
  DateTime time;
  Values values;

  Daily({
    required this.time,
    required this.values,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        time: DateTime.parse(json["time"]),
        values: Values.fromJson(json["values"]),
      );
}

class Hourly {
  DateTime time;
  Values values;

  Hourly({
    required this.time,
    required this.values,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        time: DateTime.parse(json["time"]),
        values: Values.fromJson(json["values"]),
      );
}
