import 'package:weather_app/modules/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.condition,
    required super.temperature,
    required super.minTemperature,
    required super.maxTemperature,
    required super.city,
    required super.type,
    required super.date,
  });
}
