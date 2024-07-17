import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/locators/locator.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_city.repository.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_weather.repository.dart';
import 'package:weather_app/modules/weather/views/home/home.controller.dart';

class Providers extends StatelessWidget {
  const Providers({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherHomeController(
            weatherRepository: locator<IWeatherRepository>(),
            cityRepository: locator<ICityRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
