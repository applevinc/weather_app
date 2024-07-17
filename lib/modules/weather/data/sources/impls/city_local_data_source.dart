import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_local_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';

class CityLocalDataSource implements ICityLocalDataSource {
  @override
  Future<void> addFavoriteCity(CityModel city) async {
    // TODO: implement addFavoriteCity
    throw InternalFailure();
  }

  @override
  Future<List<CityModel>> getFavoriteCities() async {
    // TODO: implement getFavoriteCities
    throw InternalFailure();
  }

  @override
  Future<void> removeFavoriteCity(CityModel city) async {
    // TODO: implement removeFavoriteCity
    throw InternalFailure();
  }
}
