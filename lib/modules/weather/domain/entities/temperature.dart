import 'package:weather_app/modules/weather/data/models/temperature.model.dart';

class Temperature {
  final double value;

  const Temperature(this.value);

  String get formatted => '${value.round()}°C';

  factory Temperature.fromModel(TemperatureModel model) {
    return Temperature(model.value);
  }
}
