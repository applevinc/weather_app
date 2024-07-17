import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/models/weather.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_weather_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';

const _apiKey = 'f5bdd37d0b0322e577adcc0e87e2c524';

class WeatherDataSource implements IWeatherDataSource {
  @override
  Future<WeatherModel> getMyWeatherInformation() async {
    return await fetchDataAndHandleErrors(() async {
      final currentPosition = await _getCurrentLocation();
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition.latitude}&lon=${currentPosition.longitude}&appid=$_apiKey';
      final reponse = await Dio().get(url);
      if (reponse.statusCode == 200) {
        log('RESPONSE DATA: ${reponse.data}');
        return WeatherModel.fromJson(reponse.data);
      } else {
        throw Failure('Something went wrong while fetching weather data');
      }
    });
  }

  Future<Position> _getCurrentLocation() async {
    LocationPermission permission;

    // Check if location services are enabled
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      throw Failure('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Failure('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Failure('Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Future<WeatherModel> getWeatherByCity(CityModel city) async {
    return await fetchDataAndHandleErrors(() async {
      final location = city.location;
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$_apiKey';
      final reponse = await Dio().get(url);
      if (reponse.statusCode == 200) {
        log('RESPONSE DATA: ${reponse.data}');
        return WeatherModel.fromJson(reponse.data);
      } else {
        throw Failure('Something went wrong while fetching weather data');
      }
    });
  }
}
