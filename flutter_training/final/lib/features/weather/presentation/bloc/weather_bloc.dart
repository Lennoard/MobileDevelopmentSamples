import 'package:bloc_sample/common/errors.dart';
import 'package:bloc_sample/features/weather/data/models/weather.dart';
import 'package:bloc_sample/features/weather/domain/repositories/weather_repository.dart';
import 'package:bloc_sample/features/weather/presentation/bloc/weather_event.dart';
import 'package:bloc_sample/features/weather/presentation/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(const WeatherInitial()) {
    on<WeatherEvent>(_onGetWeather);
  }

  _onGetWeather(WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoading());

    try {
      Weather? weather;
      if (event is GetWeather) {
        weather = await repository.fetchWeather(event.cityName);
      } else if (event is GetDetailedWeather) {
        weather = await repository.fetchDetailedWeather(event.cityName);
      }

      if (weather != null) {
        emit(WeatherLoaded(weather));
      }
    } on NetworkError {
      emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
