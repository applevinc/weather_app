import 'package:weather_app/data/models/city.model.dart';
import 'package:weather_app/data/sources/interfaces/i_weather_data_source.dart';
import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/i_weather.repository.dart';

class WeatherRepository implements IWeatherRepository {
  WeatherRepository({required IWeatherDataSource dataSource}) : _dataSource = dataSource;

  final IWeatherDataSource _dataSource;

  @override
  Future<Weather> getMyWeatherInformation() async {
    final result = await _dataSource.getMyWeatherInformation();
    return Weather.fromModel(result);
  }

  @override
  Future<Weather> getWeatherByCity(City city) async {
    final cityModel = CityModel.fromEntity(city);
    final result = await _dataSource.getWeatherByCity(cityModel);
    return Weather.fromModel(result);
  }
}
