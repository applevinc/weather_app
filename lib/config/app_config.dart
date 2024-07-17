import 'package:get_it/get_it.dart';

enum AppEnvironment {
  /// Development environment running locally and with mocked(fake) data sources
  mock,

  /// Development environment running with test remote data sources
  qa,

  /// Production environment
  prod,
}

class AppConfig {
  final AppEnvironment appEnvironment;
  final GetIt locator;
  final String appName;
  final String? description;
  final String? baseUrl;

  const AppConfig({
    required this.appEnvironment,
    required this.locator,
    required this.appName,
    this.description,
    this.baseUrl,
  });
}
