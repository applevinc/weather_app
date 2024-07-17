import 'package:dio/dio.dart';
import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';

abstract class _Urls {
  static String cities =
      'https://creditzikoyi-my.sharepoint.com/personal/oeminokanju_renmoney_com/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Foeminokanju%5Frenmoney%5Fcom%2FDocuments%2FMobile%20Assessment%2Fng%2Ejson&parent=%2Fpersonal%2Foeminokanju%5Frenmoney%5Fcom%2FDocuments%2FMobile%20Assessment&ga=1';
}

class CityRemoteDataSource implements ICityDataSource {
  @override
  Future<List<CityModel>> getAll() async {
    return await fetchDataAndHandleErrors(() async {
      final response = await Dio().get(_Urls.cities);

      if (response.statusCode == 200) {
        final List collection = response.data;
        return collection.map((e) => CityModel.fromJson(e)).toList();
      } else {
        throw Failure('Something went wrong while fetching cities');
      }
    });
  }

  @override
  Future<List<CityModel>> getFavoriteCities() async {
    return await fetchDataAndHandleErrors(() async {
      final response = await Dio().get(_Urls.cities);

      if (response.statusCode == 200) {
        final List collection = response.data;
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
      } else {
        throw Failure('Something went wrong while fetching cities');
      }
    });
  }
}
