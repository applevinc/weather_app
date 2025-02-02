import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/models/location.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/utils/functions.dart';

class FakeCityDataSource implements ICityDataSource {
  @override
  Future<List<CityModel>> getAll() async {
    await fakeNetworkDelay();
    return List.generate(
      10,
      (index) => CityModel(
        id: faker.guid.guid(),
        name: faker.address.city(),
        location: LocationModel(
          longitude: faker.geo.longitude(),
          latitude: faker.geo.latitude(),
        ),
      ),
    );
  }

  @override
  Future<List<CityModel>> getFavoriteCities() async {
    await fakeNetworkDelay();
    final cities = List.generate(
      3,
      (index) => CityModel(
        id: faker.guid.guid(),
        name: faker.address.city(),
        location: LocationModel(
          longitude: faker.geo.longitude(),
          latitude: faker.geo.latitude(),
        ),
      ),
    );
    return [];
  }
}
