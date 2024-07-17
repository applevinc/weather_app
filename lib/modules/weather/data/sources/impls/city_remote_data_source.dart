import 'dart:convert';

import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';
import 'package:flutter/services.dart' show rootBundle;

class CityRemoteDataSource implements ICityDataSource {
  @override
  Future<List<CityModel>> getAll() async {
    return await fetchDataAndHandleErrors(() async {
      final citiesString = await rootBundle.loadString('assets/ng.json');
      final List collection = jsonDecode(citiesString);
      return collection.map((e) => CityModel.fromJson(e)).toList();
    });
  }

  @override
  Future<List<CityModel>> getFavoriteCities() async {
    return await fetchDataAndHandleErrors(() async {
      final citiesString = await rootBundle.loadString('assets/ng.json');
      final List collection = jsonDecode(citiesString);
      final cities = collection.map((e) => CityModel.fromJson(e)).toList();
      List<CityModel> filteredCities = [];

      for (final city in cities) {
        if (city.name.toLowerCase() == 'lagos') {
          filteredCities.add(city);
        }

        if (city.name.toLowerCase() == 'ibadan') {
          filteredCities.add(city);
        }

        if (city.name.toLowerCase() == 'abuja') {
          filteredCities.add(city);
        }
      }

      return filteredCities;
    });
  }
}
