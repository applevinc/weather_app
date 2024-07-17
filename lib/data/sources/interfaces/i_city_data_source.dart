import 'package:weather_app/data/models/city.model.dart';

abstract class ICityDataSource {
  Future<List<CityModel>> getAll();
  Future<List<CityModel>> getFavoriteCities();
}
