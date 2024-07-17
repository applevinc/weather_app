import 'package:weather_app/data/models/city.model.dart';
import 'package:weather_app/data/models/temperature.model.dart';
import 'package:weather_app/data/models/weather.model.dart';
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

  factory Weather.fromModel(WeatherModel model) {
    return Weather(
      condition: model.condition,
      temperature: Temperature.fromModel(model.temperature as TemperatureModel),
      minTemperature: Temperature.fromModel(model.minTemperature as TemperatureModel),
      maxTemperature: Temperature.fromModel(model.maxTemperature as TemperatureModel),
      city: City.fromModel(model.city as CityModel),
      type: model.type,
      date: model.date,
    );
  }
}
