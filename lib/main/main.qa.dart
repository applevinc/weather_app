import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/config/app_config.dart';
import 'package:weather_app/config/locators/locator.dart';
import 'package:weather_app/config/locators/qa.locator.dart';
import 'package:weather_app/config/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    final config = AppConfig(
      appEnvironment: AppEnvironment.qa,
      appName: '$appName(qa)',
      locator: qaLocator,
    );
    initLocator(envLocator: config.locator);
    initLocatorForEnv(appConfig: config);
    runApp(const Providers(child: App()));
  });
}
