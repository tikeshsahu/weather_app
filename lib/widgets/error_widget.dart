import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/weather/bloc/weather_bloc.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(message),
        ),
        TextButton.icon(
          onPressed: () {
            context.read<WeatherBloc>().add(const FetchWeatherData());
          },
          icon: const Icon(Icons.replay),
          label: const Text("Retry"),
        )
      ],
    );
  }
}
