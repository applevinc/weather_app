import 'package:weather_app/data/models/city.model.dart';

abstract class ICityLocalDataSource {
  Future<List<CityModel>> getFavoriteCities();
  Future<void> addFavoriteCity(CityModel city);
  Future<void> removeFavoriteCity(CityModel city);
}
