import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/models/location.model.dart';
import 'package:weather_app/modules/weather/data/models/temperature.model.dart';
import 'package:weather_app/modules/weather/data/models/weather.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_weather_data_source.dart';
import 'package:weather_app/modules/weather/domain/enums/weather_type.enum.dart';
import 'package:weather_app/utils/functions.dart';

class FakeWeatherDataSource implements IWeatherDataSource {
  @override
  Future<WeatherModel> getMyWeatherInformation() async {
    await fakeNetworkDelay();
    final myCity = CityModel(
      id: faker.guid.guid(),
      name: faker.address.city(),
      location: LocationModel(
        latitude: faker.geo.latitude(),
        longitude: faker.geo.longitude(),
      ),
    );

    return WeatherModel(
      city: myCity,
      temperature: TemperatureModel(random.nextInt(100).toDouble()),
      minTemperature: TemperatureModel(random.nextInt(100).toDouble()),
      maxTemperature: TemperatureModel(random.nextInt(100).toDouble()),
      type: getOneRandomWeatherType(),
      condition: faker.lorem.sentence(),
    );
  }

  @override
  Future<WeatherModel> getWeatherByCity(CityModel city) async {
    await fakeNetworkDelay();
    return WeatherModel(
      city: city,
      temperature: TemperatureModel(random.nextInt(100).toDouble()),
      minTemperature: TemperatureModel(random.nextInt(100).toDouble()),
      maxTemperature: TemperatureModel(random.nextInt(100).toDouble()),
      type: getOneRandomWeatherType(),
      condition: faker.lorem.sentence(),
    );
  }
}

WeatherType getOneRandomWeatherType() {
  final index = random.nextInt(WeatherType.values.length);
  return WeatherType.values[index];
}
