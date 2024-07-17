import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/domain/entities/temperature.dart';
import 'package:weather_app/domain/enums/weather_type.enum.dart';

class Weather {
  final String condition;
  final Temperature temperature;
  final Temperature minTemperature;
  final Temperature maxTemperature;
  final City city;
  final WeatherType type;
  final DateTime date;

  Weather({
    required this.condition,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.city,
    required this.type,
    required this.date,
  });
}
