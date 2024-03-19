part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class ViewDailyForecastClickEvent extends WeatherEvent {}

class ViewHourlyForecastClickEvent extends WeatherEvent {}

class FetchWeatherData extends WeatherEvent {
  final String? city;

  const FetchWeatherData({this.city});

  @override
  List<Object> get props => [city!];
}
