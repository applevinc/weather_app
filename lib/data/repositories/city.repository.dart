import 'package:weather_app/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/domain/entities/city.dart';
import 'package:weather_app/domain/repositories/i_city.repository.dart';

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
}
