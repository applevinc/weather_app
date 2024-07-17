import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/models/weather.model.dart';

abstract class IWeatherDataSource {
  Future<WeatherModel> getMyWeatherInformation();
  Future<WeatherModel> getWeatherByCity(CityModel city);
}
