import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/models/location.model.dart';
import 'package:weather_app/modules/weather/data/models/temperature.model.dart';
import 'package:weather_app/modules/weather/domain/entities/weather.dart';
import 'package:weather_app/modules/weather/domain/enums/weather_type.enum.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.condition,
    required super.temperature,
    required super.minTemperature,
    required super.maxTemperature,
    required super.city,
    required super.type,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      condition: json['weather'][0]['description'],
      temperature: TemperatureModel(json['main']['temp']),
      minTemperature: TemperatureModel(json['main']['temp_min']),
      maxTemperature: TemperatureModel(json['main']['temp_max']),
      city: CityModel(
        id: json['id'].toString(),
        name: json['name'],
        location: LocationModel(
          latitude: json['coord']['lat'],
          longitude: json['coord']['lon'],
        ),
      ),
      type: weatherTypeFromString(json['weather'][0]['main']),
    );
  }
}
