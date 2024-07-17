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
    getFavoriteCities();
  }

  late final IWeatherRepository _weatherRepository;

  late final ICityRepository _cityRepository;

  List<City> _favoriteCities = [];

  List<City> get favoriteCities => _favoriteCities;

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

  Future<void> getFavoriteCities() async {
    clearErrors();

    try {
      setBusyForObject(WeatherState.getFavoriteCities, true);
      final result = await _cityRepository.getFavoriteCities();
      _favoriteCities = result;
      _tabs = result.map((e) => Tab(text: e.name)).toList();

      if (favoriteCities.isNotEmpty) {
        _currentCity = favoriteCities.first;
        getWeather();
      }
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

  Future<void> addFavoriteCity(City city) async {
    // optimistic update
    _favoriteCities.add(city);
    notifyListeners();

    try {
      await _cityRepository.addFavoriteCity(city);
      // most recent tab is always the last
      final lastTabIndex = _tabs.length - 1;
      onTabChanged(lastTabIndex);
    } catch (e) {
      _favoriteCities.removeLast();

      if (e is Failure) {
        rethrow;
      } else {
        throw InternalFailure();
      }
    } finally {
      notifyListeners();
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

      _weather = null;
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
}
