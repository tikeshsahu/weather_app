import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/lat_land.dart';
import 'package:weather_app/model/realtime_weather.data_model.dart';
import 'package:weather_app/model/weather_forecast_data_model.dart';

class Helper {
  static String getFormattedTime(DateTime dateTime) {
    dateTime.add(const Duration(hours: 5)).add(const Duration(minutes: 30));

    final now = dateTime ?? DateTime.now();
    final hour = (now.hour % 12) == 0 ? 12 : (now.hour % 12);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  static String getFormattedDate(DateTime? dateTime) {
    final now = dateTime ?? DateTime.now();
    return '${now.day} ${getMonth(now.month)} ${now.year}';
  }

  static getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Invalid';
    }
  }

  static Future<LatLand> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return LatLand(lat: position.latitude, lng: position.longitude);
  }

  static String getNameFromLocationName(
      {RealtimeWeatherDataModel? realtimeWeatherDataModel,
      WeatherForecastDataModel? weatherForecastDataModel}) {
    if (realtimeWeatherDataModel!.location.name != null) {
      return realtimeWeatherDataModel.location.name!;
    }

    if (weatherForecastDataModel!.location.name != null) {
      return weatherForecastDataModel.location.name!;
    }

    return "Unknown";
  }
}
