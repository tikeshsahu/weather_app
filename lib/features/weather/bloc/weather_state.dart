part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class LoadingState extends WeatherState {}

final class SuccessState extends WeatherState {
  final String? cityName;
  final RealtimeWeatherDataModel realtimeWeatherModel;
  final WeatherForecastDataModel weatherForecastModel;
  const SuccessState({
    this.cityName,
    required this.realtimeWeatherModel,
    required this.weatherForecastModel,
  });

  @override
  List<Object> get props => [realtimeWeatherModel, weatherForecastModel];
}

final class ErrorState extends WeatherState {
  String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class ViewDailyForecastState extends WeatherState {}

final class ViewHourlyForecastState extends WeatherState {}
