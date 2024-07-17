import 'package:flutter/widgets.dart';
import 'package:weather_app/assets/images.dart';
import 'package:weather_app/modules/weather/domain/enums/weather_type.enum.dart';

class WeatherImageComponent extends StatelessWidget {
  const WeatherImageComponent({
    super.key,
    required this.weathertype,
    required this.size,
  });

  final WeatherType weathertype;
  final double size;

  @override
  Widget build(BuildContext context) {
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
