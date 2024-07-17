import 'package:weather_app/data/models/temperature.model.dart';

class Temperature {
  final double value;

  const Temperature(this.value);

  String get formatted => '${value.toStringAsFixed(1)}°C';

  factory Temperature.fromModel(TemperatureModel model) {
    return Temperature(model.value);
  }
}
