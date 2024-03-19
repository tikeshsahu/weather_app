import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/weather/bloc/weather_bloc.dart';
import '../model/weather_forecast_data_model.dart';
import '../utils/helper.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required this.weatherForecastModel,
  });

  final WeatherForecastDataModel weatherForecastModel;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Hourly",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: weatherForecastModel.timelines.hourly.length,
                  itemBuilder: (BuildContext context, int index) {
                    String temp =
                        "${weatherForecastModel.timelines.hourly[index].values.temperatureApparent.toStringAsFixed(0)}°";
                    String date = Helper.getFormattedDate(
                        weatherForecastModel.timelines.hourly[index].time);

                    String time = Helper.getFormattedTime(
                        weatherForecastModel.timelines.hourly[index].time);

                    return ListTile(
                      title: Text(temp),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(date),
                          Text(time),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
