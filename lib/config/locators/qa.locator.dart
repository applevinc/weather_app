import 'package:get_it/get_it.dart';
import 'package:weather_app/config/app_config.dart';
import 'package:weather_app/modules/weather/data/sources/impls/city_remote_data_source.dart';
import 'package:weather_app/modules/weather/data/sources/impls/city_local_data_source.dart';
import 'package:weather_app/modules/weather/data/sources/impls/weather_data_source.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_local_data_source.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_weather_data_source.dart';

final GetIt qaLocator = GetIt.instance;

void initLocatorForEnv({required AppConfig appConfig}) async {
  print('Mock locator init....');
  qaLocator.registerLazySingleton<AppConfig>(() => appConfig);

  qaLocator.registerLazySingleton<IWeatherDataSource>(
    () => WeatherDataSource(),
  );

  qaLocator.registerLazySingleton<ICityDataSource>(
    () => CityRemoteDataSource(),
  );

  qaLocator.registerLazySingleton<ICityLocalDataSource>(
    () => CityLocalDataSource(),
  );
}
