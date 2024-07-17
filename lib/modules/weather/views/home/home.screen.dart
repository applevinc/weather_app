import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/assets/images.dart';
import 'package:weather_app/modules/weather/domain/enums/weather_type.enum.dart';
import 'package:weather_app/modules/weather/views/cities/cities.sheet.dart';
import 'package:weather_app/modules/weather/views/home/home.controller.dart';
import 'package:weather_app/styles/spacing.dart';
import 'package:weather_app/utils/models/failure.model.dart';
import 'package:weather_app/widgets/error_view.dart';
import 'package:weather_app/widgets/loading_overlay_view.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherHomeController>().getFavoriteCities(vsync: this);
    });
  }

  void addCity() async {
    final controller = context.read<WeatherHomeController>();
    final city = await showCitiesSheet(
      context: context,
      favoriteCities: controller.favoriteCities,
    );

    if (!mounted) {
      return;
    }

    if (city == null) {
      return;
    }

    try {
      await controller.addFavoriteCity(city: city, vsync: this);
    } on Failure catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherHomeController>();

    if (!controller.hasCompletedUiFrames) {
      return const SizedBox.shrink();
    }

    return LoadingOverlayView(
      show: controller.busy(WeatherState.getFavoriteCities),
      child: Builder(
        builder: (context) {
          if (controller.busy(WeatherState.getFavoriteCities)) {
            return const Scaffold(
              body: SizedBox.shrink(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Weather App'),
              bottom: TabBar(
                controller: controller.tabController,
                tabs: controller.tabs,
                isScrollable: true,
                padding: EdgeInsets.zero,
                onTap: controller.onTabChanged,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.location_pin,
                  ),
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (controller.busy(WeatherState.getWeather)) {
                  return const CustomLoader();
                }

                if (controller.hasErrorForKey(WeatherState.getWeather)) {
                  return ErrorView(
                    error: controller.error(WeatherState.getWeather),
                    retry: controller.getWeather,
                  );
                }

                final city = controller.currentCity;
                final weather = controller.weather;

                if (weather == null || city == null) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: AppPadding.defaultPadding,
                  child: Column(
                    children: [
                      const Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          city.name,
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _Image(weathertype: weather.type),
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
                      const Spacer(flex: 2),
                    ],
                  ),
                );
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: addCity,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({super.key, required this.weathertype});

  final WeatherType weathertype;

  @override
  Widget build(BuildContext context) {
    final size = 250.h;

    switch (weathertype) {
      case WeatherType.clouds:
        return Image.asset(
          AppImages.cloudy,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );

      case WeatherType.rain:
        return Image.asset(
          AppImages.rain,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );

      case WeatherType.sunny:
        return Image.asset(
          AppImages.sunny,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );

      case WeatherType.windy:
        return Image.asset(
          AppImages.wind,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );

      default:
        return Image.asset(
          AppImages.clear,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );
    }
  }
}
