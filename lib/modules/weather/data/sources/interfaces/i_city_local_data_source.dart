import 'package:weather_app/modules/weather/data/models/city.model.dart';

abstract class ICityLocalDataSource {
  Future<List<CityModel>> getFavoriteCities();
  Future<void> addFavoriteCity(CityModel city);
  Future<void> removeFavoriteCity(CityModel city);
}
