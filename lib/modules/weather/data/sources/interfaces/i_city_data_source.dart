import 'package:weather_app/modules/weather/data/models/city.model.dart';

abstract class ICityDataSource {
  Future<List<CityModel>> getAll();
  Future<List<CityModel>> getFavoriteCities();
}
