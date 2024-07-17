import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/config/locators/locator.dart';
import 'package:weather_app/modules/weather/views/home/home.screen.dart';

import 'config/app_config.dart';
import 'styles/theme.dart';

const appName = 'Weather App';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          title: locator<AppConfig>().appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const HomeScreen(),
        );
      },
    );
  }
}
