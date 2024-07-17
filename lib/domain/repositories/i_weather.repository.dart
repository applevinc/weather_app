import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/domain/entities/weather.dart';

abstract class IWeatherRepository {
  Future<Weather> getMyWeatherInformation();
  Future<Weather> getWeatherByCity(City city);
}
