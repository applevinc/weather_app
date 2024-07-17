import 'package:weather_app/modules/weather/domain/entities/weather.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_weather.repository.dart';
import 'package:weather_app/utils/models/failure.model.dart';
import 'package:weather_app/utils/view.controller.dart';

class MyWeatherController extends ViewController {
  MyWeatherController({required IWeatherRepository weatherRepository}) {
    _weatherRepository = weatherRepository;
    getMyWeather();
  }

  late final IWeatherRepository _weatherRepository;

  Weather? _weather;

  Weather? get weather => _weather;

  String get temperatureRange {
    if (weather == null) {
      return '';
    }

    return 'H: ${weather!.maxTemperature.formatted} - L: ${weather!.minTemperature.formatted}';
  }

  Future<void> getMyWeather() async {
    clearErrors();

    try {
      setBusy(true);
      _weather = await _weatherRepository.getMyWeatherInformation();
    } on Failure catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
