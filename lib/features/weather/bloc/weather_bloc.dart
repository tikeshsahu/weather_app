import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/realtime_weather.data_model.dart';
import '../../../model/weather_forecast_data_model.dart';
import '../../../services/api_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final _apiService = ApiService();
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {});
    on<FetchWeatherData>(fetchWeatherData);
    on<ViewDailyForecastClickEvent>(viewDailyForecastClickEvent);
    on<ViewHourlyForecastClickEvent>(viewHourlyForecastClickEvent);
  }

  FutureOr<void> fetchWeatherData(
      FetchWeatherData event, Emitter<WeatherState> emit) async {
    try {
      String? cityName = event.city;
      emit(LoadingState());

      await Future.wait([
        _apiService.fetchRealTimeWeather(cityName),
        _apiService.fetchForecastWeather(cityName)
      ]).then((value) {
        if (value[0].$2 && value[1].$2) {
          emit(
            SuccessState(
              cityName: cityName,
              realtimeWeatherModel: value[0].$1 as RealtimeWeatherDataModel,
              weatherForecastModel: value[1].$1 as WeatherForecastDataModel,
            ),
          );
        } else if (!value[0].$2) {
          emit(ErrorState(message: value[0].$3));
        } else if (!value[1].$2) {
          emit(ErrorState(message: value[1].$3));
        } else {
          emit(ErrorState(message: "Something went wrong, please try again."));
        }
      });
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  FutureOr<void> viewHourlyForecastClickEvent(
      ViewHourlyForecastClickEvent event, Emitter<WeatherState> emit) {
    emit(ViewHourlyForecastState());
  }

  FutureOr<void> viewDailyForecastClickEvent(
      ViewDailyForecastClickEvent event, Emitter<WeatherState> emit) {
    emit(ViewDailyForecastState());
  }
}
