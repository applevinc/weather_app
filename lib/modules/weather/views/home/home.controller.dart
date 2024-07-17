import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/modules/weather/domain/entities/weather.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_city.repository.dart';
import 'package:weather_app/modules/weather/domain/repositories/i_weather.repository.dart';
import 'package:weather_app/utils/models/failure.model.dart';
import 'package:weather_app/utils/view.controller.dart';

enum WeatherState {
  getFavoriteCities,
  getWeather,
}

class WeatherHomeController extends ViewController {
  WeatherHomeController({
    required IWeatherRepository weatherRepository,
    required ICityRepository cityRepository,
  }) {
    _cityRepository = cityRepository;
    _weatherRepository = weatherRepository;
  }

  bool hasCompletedUiFrames = false;

  late final IWeatherRepository _weatherRepository;

  late final ICityRepository _cityRepository;

  List<City> _favoriteCities = [];

  List<City> get favoriteCities => _favoriteCities;

  TabController? tabController;

  List<Tab> _tabs = [];

  List<Tab> get tabs => _tabs;

  void onTabChanged(int index) {
    _currentCity = _favoriteCities[index];
    getWeather();
  }

  City? _currentCity;

  City? get currentCity => _currentCity;

  Weather? _weather;

  Weather? get weather => _weather;

  String get temperatureRange {
    if (weather == null) {
      return '';
    }

    return 'H: ${weather!.maxTemperature.formatted} - L: ${weather!.minTemperature.formatted}';
  }

  Future<void> getFavoriteCities({required TickerProvider vsync}) async {
    clearErrors();
    hasCompletedUiFrames = true;

    try {
      setBusyForObject(WeatherState.getFavoriteCities, true);
      final result = await _cityRepository.getFavoriteCities();

      if (result.isEmpty) {
        return;
      }

      _favoriteCities = result;
      _tabs = result.map((e) => Tab(text: e.name)).toList();
      tabController = TabController(
        length: tabs.length,
        vsync: vsync,
      );
      _currentCity = favoriteCities.first;
      getWeather();
    } catch (e) {
      if (e is Failure) {
        setError(e);
      } else {
        setError(InternalFailure());
      }
    } finally {
      setBusyForObject(WeatherState.getFavoriteCities, false);
    }
  }

  Future<void> addFavoriteCity({
    required City city,
    required TickerProvider vsync,
  }) async {
    // optimistic update
    _favoriteCities.add(city);
    _currentCity = city;
    _tabs.add(Tab(text: city.name));
    notifyListeners();
    tabController = TabController(
      length: tabs.length,
      vsync: vsync,
    );
    tabController?.animateTo(_tabs.length - 1);

    try {
      setBusyForObject(WeatherState.getWeather, true);
      await _cityRepository.addFavoriteCity(city);
      _weather = await _weatherRepository.getWeatherByCity(city);
    } catch (e) {
      _favoriteCities.removeLast();
      _tabs.removeLast();

      if (e is Failure) {
        rethrow;
      } else {
        throw InternalFailure();
      }
    } finally {
      setBusyForObject(WeatherState.getWeather, false);
    }
  }

  Future<void> removeFavoriteCity(City city) async {
    final index = _favoriteCities.indexWhere((element) => city.id == element.id);
    final notFound = index == -1;

    if (notFound) {
      return;
    }

    // optimistic update
    _favoriteCities.removeAt(index);
    notifyListeners();

    try {
      await _cityRepository.removeFavoriteCity(city);
      _favoriteCities.removeAt(index);
    } catch (e) {
      _favoriteCities.insert(index, city);

      if (e is Failure) {
        rethrow;
      } else {
        throw InternalFailure();
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> getWeather() async {
    clearErrors();

    try {
      if (currentCity == null) {
        throw InternalFailure();
      }

      setBusyForObject(WeatherState.getWeather, true);
      _weather = await _weatherRepository.getWeatherByCity(currentCity!);
    } catch (e) {
      log(e.toString());

      if (e is Failure) {
        setErrorForObject(WeatherState.getWeather, e);
      } else {
        setErrorForObject(WeatherState.getWeather, InternalFailure());
      }
    } finally {
      setBusyForObject(WeatherState.getWeather, false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }
}
