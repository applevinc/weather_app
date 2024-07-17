import 'package:weather_app/domain/entities/city.dart';

abstract class ICityRepository {
  Future<List<City>> getAll();
  Future<List<City>> getFavoriteCities();
  Future<void> addFavoriteCity(City city);
  Future<void> removeFavoriteCity(City city);
}
