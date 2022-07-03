import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelsius;
  final double? temperatureFahrenheit;

  const Weather({
    required this.cityName,
    required this.temperatureCelsius,
    this.temperatureFahrenheit,
  });

  @override
  List<Object> get props =>
      [cityName, temperatureCelsius, temperatureFahrenheit ?? 0];
}
