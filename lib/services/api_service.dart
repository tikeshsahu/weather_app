import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/model/lat_land.dart';
import 'package:weather_app/model/realtime_weather.data_model.dart';
import 'package:weather_app/model/weather_forecast_data_model.dart';
import 'package:weather_app/utils/helper.dart';

import '../res/constants.dart';
import 'app_interceptor.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio();
    dio
      ..options.baseUrl = BASE_URL
      ..httpClientAdapter
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10)
      ..options.headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
      };

    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor());
  }

  Future<(RealtimeWeatherDataModel?, bool, String)> fetchRealTimeWeather(
      [String? city]) async {
    try {
      LatLand latLand = await Helper.getUserLocation();
      var queryParameters = {
        "location": city ?? "${latLand.lat},${latLand.lng}",
      };
      var res = await dio.get("realtime", queryParameters: queryParameters);
      return (
        RealtimeWeatherDataModel.fromJson(res.data),
        true,
        "",
      );
    } on DioException catch (e) {
      log(e.message.toString());
      String message = e.response!.statusMessage.toString();
      return (null, false, message);
    } catch (e) {
      log(e.toString());
      return (null, false, e.toString());
    }
  }

  Future<(WeatherForecastDataModel?, bool, String)> fetchForecastWeather(
      [String? city]) async {
    try {
      LatLand latLand = await Helper.getUserLocation();
      var queryParameters = {
        "location": city ?? "${latLand.lat},${latLand.lng}",
      };
      var res = await dio.get("forecast", queryParameters: queryParameters);

      return (
        // NewsDataModel.fromJson(json.decode(res.data.toString())),
        WeatherForecastDataModel.fromJson(res.data),
        true,
        ""
      );
    } on DioException catch (e) {
      log(e.message.toString());
      String message = e.response!.statusMessage.toString();
      return (null, false, message);
    } catch (e) {
      log(e.toString());
      return (null, false, e.toString());
    }
  }
}
