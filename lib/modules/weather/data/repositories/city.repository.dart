import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_city.repository.dart';

class CityRepository implements ICityRepository {
  CityRepository({required ICityDataSource dataSource}) : _dataSource = dataSource;

  final ICityDataSource _dataSource;

  final List<City> _cities = [];

  @override
  Future<List<City>> getAll() async {
    if (_cities.isNotEmpty) {
      return _cities;
    }

    final result = await _dataSource.getAll();
    final cities = result.map((e) => City.fromModel(e)).toList();
    _cities.addAll(cities);
    return _cities;
  }

  @override
  Future<void> addFavoriteCity(City city) {
    // TODO: implement addFavoriteCity
    throw UnimplementedError();
  }

  @override
  Future<List<City>> getFavoriteCities() {
    // TODO: implement getFavoriteCities
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavoriteCity(City city) {
    // TODO: implement removeFavoriteCity
    throw UnimplementedError();
  }
}
