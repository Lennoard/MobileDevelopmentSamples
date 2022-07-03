import 'package:bloc_sample/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:bloc_sample/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/weather/presentation/pages/weather_search_page.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        create: (context) => WeatherBloc(WeatherRepositoryImpl()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}
