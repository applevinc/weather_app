import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/modules/weather/views/cities/cities.sheet.dart';
import 'package:weather_app/modules/weather/views/home/home.controller.dart';
import 'package:weather_app/modules/weather/views/my_weather/my_weather.sheet.dart';
import 'package:weather_app/styles/colors.dart';
import 'package:weather_app/styles/spacing.dart';
import 'package:weather_app/utils/models/failure.model.dart';
import 'package:weather_app/widgets/error_view.dart';
import 'package:weather_app/widgets/loading_overlay_view.dart';
import 'package:weather_app/widgets/weather_image.component.dart';

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

  void delete() async {
    try {
      await context.read<WeatherHomeController>().removeCurrentCity(vsync: this);
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

    return Builder(
      builder: (context) {
        if (controller.busy(WeatherState.getFavoriteCities)) {
          return const Scaffold(
            body: CustomLoader(),
          );
        }

        return LoadingOverlayView(
          show: controller.busy(WeatherState.removeCity),
          child: Scaffold(
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
                  onPressed: () {
                    showMyWeatherSheet(context);
                  },
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
                      WeatherImageComponent(
                        weathertype: weather.type,
                        size: 250.h,
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
                      if (controller.tabs.length > 1)
                        TextButton(
                          onPressed: delete,
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.error,
                            ),
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
          ),
        );
      },
    );
  }
}
