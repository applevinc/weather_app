import 'package:get_it/get_it.dart';
import 'package:weather_app/config/app_config.dart';
import 'package:weather_app/data/repositories/city.repository.dart';
import 'package:weather_app/data/repositories/weather.repository.dart';
import 'package:weather_app/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/data/sources/interfaces/i_weather_data_source.dart';
import 'package:weather_app/domain/repositories/i_city.repository.dart';
import 'package:weather_app/domain/repositories/i_weather.repository.dart';

final GetIt _locator = GetIt.instance;

final locator = GetIt.instance;

final baseUrl = locator<AppConfig>().baseUrl;

final environment = locator<AppConfig>().appEnvironment;

void initLocator({required GetIt envLocator}) async {
  print('Global DI init....');
  _locator.registerLazySingleton<GetIt>(() => envLocator);

  locator.registerLazySingleton<IWeatherRepository>(
    () => WeatherRepository(
      dataSource: locator<IWeatherDataSource>(),
    ),
  );

  locator.registerLazySingleton<ICityRepository>(
    () => CityRepository(
      dataSource: locator<ICityDataSource>(),
    ),
  );
}
