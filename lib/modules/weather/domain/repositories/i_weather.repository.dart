import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/modules/weather/domain/entities/weather.dart';

abstract class IWeatherRepository {
  Future<Weather> getMyWeatherInformation();
  Future<Weather> getWeatherByCity(City city);
}
