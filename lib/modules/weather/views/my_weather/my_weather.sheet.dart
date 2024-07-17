import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/locators/locator.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_weather.repository.dart';
import 'package:weather_app/modules/weather/views/my_weather/my_weather.controller.dart';
import 'package:weather_app/styles/spacing.dart';
import 'package:weather_app/widgets/error_view.dart';
import 'package:weather_app/widgets/loading_overlay_view.dart';
import 'package:weather_app/widgets/weather_image.component.dart';

Future<dynamic> showMyWeatherSheet(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (_) => ChangeNotifierProvider(
      create: (_) => MyWeatherController(
        weatherRepository: locator<IWeatherRepository>(),
      ),
      child: const _Body(),
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Current Location Weather',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer<MyWeatherController>(
            builder: (_, controller, __) {
              if (controller.isBusy) {
                return const CustomLoader();
              }

              if (controller.hasError) {
                return ErrorView(
                  error: controller.modelError,
                  retry: controller.getMyWeather,
                );
              }

              final weather = controller.weather;

              if (weather == null) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: AppPadding.defaultPadding,
                child: Column(
                  children: [
                    WeatherImageComponent(
                      weathertype: weather.type,
                      size: 120.h,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      weather.temperature.formatted,
                      style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      weather.condition,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff3C3C43),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      controller.temperatureRange,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
