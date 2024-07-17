import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_local_data_source.dart';
import 'package:weather_app/utils/functions.dart';

class FakeCityLocalDataSource implements ICityLocalDataSource {
  @override
  Future<void> addFavoriteCity(CityModel city) async {
    await fakeNetworkDelay();
  }

  @override
  Future<List<CityModel>> getFavoriteCities() async {
    await fakeNetworkDelay();
    return [];
  }

  @override
  Future<void> removeFavoriteCity(CityModel city) async {
    await fakeNetworkDelay();
  }
}
