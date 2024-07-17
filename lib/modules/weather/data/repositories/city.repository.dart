import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_local_data_source.dart';
import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_city.repository.dart';

class CityRepository implements ICityRepository {
  CityRepository({
    required ICityDataSource remoteDataSource,
    required ICityLocalDataSource localDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final ICityDataSource _remoteDataSource;

  final ICityLocalDataSource _localDataSource;

  final List<City> _cities = [];

  @override
  Future<List<City>> getAll() async {
    if (_cities.isNotEmpty) {
      return _cities;
    }

    final result = await _remoteDataSource.getAll();
    final cities = result.map((e) => City.fromModel(e)).toList();
    _cities.addAll(cities);
    return _cities;
  }

  @override
  Future<List<City>> getFavoriteCities() async {
    final localFavoriteCities = await _getLocalFavoriteCities();

    if (localFavoriteCities.isNotEmpty) {
      return localFavoriteCities;
    }

    return await _getRemoteFavoriteCities();
  }

  Future<List<City>> _getLocalFavoriteCities() async {
    final result = await _localDataSource.getFavoriteCities();
    return result.map((e) => City.fromModel(e)).toList();
  }

  Future<List<City>> _getRemoteFavoriteCities() async {
    final result = await _remoteDataSource.getFavoriteCities();
    return result.map((e) => City.fromModel(e)).toList();
  }

  @override
  Future<void> addFavoriteCity(City city) async {
    final cityModel = CityModel.fromEntity(city);
    await _localDataSource.addFavoriteCity(cityModel);
  }

  @override
  Future<void> removeFavoriteCity(City city) async {
    final cityModel = CityModel.fromEntity(city);
    await _localDataSource.removeFavoriteCity(cityModel);
  }
}
