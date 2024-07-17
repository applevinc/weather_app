import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';

class CityRemoteDataSource implements ICityDataSource {
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
