import 'package:weather_app/data/models/city.model.dart';
import 'package:weather_app/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';

class CityDataSource implements ICityDataSource {
  @override
  Future<List<CityModel>> getAll() async {
    // TODO: implement getAll
    throw InternalFailure();
  }

  @override
  Future<List<CityModel>> getFavoriteCities() async {
    // TODO: implement getFavoriteCities
    throw InternalFailure();
  }
}
