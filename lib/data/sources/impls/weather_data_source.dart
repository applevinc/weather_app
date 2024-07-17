import 'package:weather_app/data/models/city.model.dart';
import 'package:weather_app/data/models/weather.model.dart';
import 'package:weather_app/data/sources/interfaces/i_weather_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';

class WeatherDataSource implements IWeatherDataSource {
  

  @override
  Future<WeatherModel> getMyWeatherInformation() async {
    // TODO: implement getMyWeatherInformation
    throw InternalFailure();
  }

  @override
  Future<WeatherModel> getWeatherByCity(CityModel city) async {
    // TODO: implement getWeatherByCity
    throw InternalFailure();
  }
}
