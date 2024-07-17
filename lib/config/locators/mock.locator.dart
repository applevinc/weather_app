import 'package:get_it/get_it.dart';
import 'package:weather_app/config/app_config.dart';
import 'package:weather_app/data/sources/fakes/fake_city_data_source.dart';
import 'package:weather_app/data/sources/fakes/fake_weather_data_source.dart';
import 'package:weather_app/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/data/sources/interfaces/i_weather_data_source.dart';

final GetIt mockLocator = GetIt.instance;

void initLocatorForEnv({required AppConfig appConfig}) async {
  print('Dev DI init....');
  mockLocator.registerLazySingleton<AppConfig>(() => appConfig);

  mockLocator.registerLazySingleton<IWeatherDataSource>(
    () => FakeWeatherDataSource(),
  );

  mockLocator.registerLazySingleton<ICityDataSource>(
    () => FakeCityDataSource(),
  );
}
