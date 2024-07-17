import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/locators/locator.dart';
import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_city.repository.dart';
import 'package:weather_app/modules/weather/views/cities/cities.controller.dart';
import 'package:weather_app/widgets/error_view.dart';

Future<City?> showCitiesSheet({
  required BuildContext context,
  required List<City> favoriteCities,
}) async {
  return await showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (_) => ChangeNotifierProvider(
      create: (_) => CitiesController(
        cityRepository: locator<ICityRepository>(),
        favoriteCities: favoriteCities,
      ),
      child: const _Body(),
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CitiesController>(
      builder: (_, controller, __) {
        if (controller.isBusy) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.hasError) {
          return ErrorView(
            error: controller.modelError,
            retry: controller.getAll,
          );
        }

        final cities = controller.cities;

        return Column(
          children: [
            Text(
              'Cities',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: cities.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final city = cities[index];

                  return ListTile(
                    title: Text(city.name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).pop(city);
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),
          ],
        );
      },
    );
  }
}
