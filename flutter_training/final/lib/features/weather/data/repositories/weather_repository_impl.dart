import 'dart:math';

import 'package:bloc_sample/common/errors.dart';
import 'package:bloc_sample/features/weather/data/models/weather.dart';
import 'package:bloc_sample/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  double cachedTempCelsius = 0.0;

  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        final random = Random();

        if (random.nextInt(100) % 2 == 0) {
          throw NetworkError();
        }

        cachedTempCelsius = 20 + random.nextInt(20) + random.nextDouble();

        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
        );
      },
    );
  }

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
          temperatureFahrenheit: cachedTempCelsius * 1.8 + 32,
        );
      },
    );
  }
}
