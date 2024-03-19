import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/model/weather_forecast_data_model.dart';
import 'package:weather_app/services/permission_service.dart';
import 'package:weather_app/utils/helper.dart';

import '../../../model/realtime_weather.data_model.dart';
import '../../../widgets/category_tile.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/forecast_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial || state is LoadingState) {
              return const LoadingWidget();
            } else if (state is ErrorState) {
              return CustomErrorWidget(
                message: state.message,
              );
            } else {
              RealtimeWeatherDataModel? realtimeWeatherModel;
              WeatherForecastDataModel? weatherForecastModel;

              if (state is SuccessState) {
                realtimeWeatherModel = state.realtimeWeatherModel;
                weatherForecastModel = state.weatherForecastModel;
              }

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        suffixIcon: controller.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  controller.clear();
                                  context
                                      .read<WeatherBloc>()
                                      .add(const FetchWeatherData());
                                },
                                icon: const Icon(
                                  Icons.close,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  context.read<WeatherBloc>().add(
                                      FetchWeatherData(
                                          city: controller.text.trim()));
                                },
                                icon: const Icon(Icons.search),
                              ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          Helper.getNameFromLocationName(
                            weatherForecastDataModel: weatherForecastModel,
                            realtimeWeatherDataModel: realtimeWeatherModel,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        Helper.getFormattedDate(
                            realtimeWeatherModel!.data.time),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "${realtimeWeatherModel.data.values.temperatureApparent.toStringAsFixed(0)}°",
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryTile(
                          label: "Wind",
                          value:
                              "${realtimeWeatherModel.data.values.windSpeed} km/h",
                        ),
                        SizedBox(width: width * 0.02),
                        CategoryTile(
                          label: "Humidity",
                          value:
                              "${realtimeWeatherModel.data.values.humidity.toStringAsFixed(0)}%",
                        ),
                      ],
                    ),
                    ForecastWidget(
                      weatherForecastModel: weatherForecastModel!,
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void fetchData() {
    Future.delayed(Duration.zero, () {
      PermissionService.requestLocationPermission().then((value) {
        if (value) {
          context.read<WeatherBloc>().add(const FetchWeatherData());
        }
      });
    });
  }
}
