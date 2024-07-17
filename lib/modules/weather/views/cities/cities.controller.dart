import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_city.repository.dart';
import 'package:weather_app/utils/models/failure.model.dart';
import 'package:weather_app/utils/view.controller.dart';

class CitiesController extends ViewController {
  CitiesController({required this.favoriteCities, required ICityRepository cityRepository}) {
    _cityRepository = cityRepository;
    getAll();
  }

  late final ICityRepository _cityRepository;

  final List<City> favoriteCities;

  List<City> _cities = [];

  List<City> get cities => _cities;

  Future<void> getAll() async {
    clearErrors();

    try {
      setBusy(true);
      _cities = await _cityRepository.getAll();
      _hideFavouriteCities();
    } on Failure catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void _hideFavouriteCities() {
    if (cities.isEmpty) {
      return;
    }

    _cities = _cities.where((element) => !favoriteCities.contains(element)).toList();
  }
}
