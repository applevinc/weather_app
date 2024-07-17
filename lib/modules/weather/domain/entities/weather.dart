import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/models/temperature.model.dart';
import 'package:weather_app/modules/weather/data/models/weather.model.dart';
import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/modules/weather/domain/entities/temperature.dart';
import 'package:weather_app/modules/weather/domain/enums/weather_type.enum.dart';

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

  factory Weather.fromModel(WeatherModel model) {
    return Weather(
      condition: model.condition,
      temperature: Temperature.fromModel(model.temperature as TemperatureModel),
      minTemperature: Temperature.fromModel(model.minTemperature as TemperatureModel),
      maxTemperature: Temperature.fromModel(model.maxTemperature as TemperatureModel),
      city: model.city,
      type: model.type,
      date: model.date,
    );
  }
}
