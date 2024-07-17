import 'package:weather_app/modules/weather/data/models/location.model.dart';
import 'package:weather_app/modules/weather/domain/entities/city.dart';
import 'package:weather_app/utils/functions.dart';

class CityModel extends City {
  const CityModel({
    required super.id,
    required super.name,
    required super.location,
  });

  factory CityModel.fromEntity(City entity) {
    return CityModel(
      id: entity.id,
      name: entity.name,
      location: entity.location,
    );
  }

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: faker.guid.guid(),
      name: json['city'],
      location: LocationModel(
        latitude: double.parse(json['lat']),
        longitude: double.parse(json['lng']),
      ),
    );
  }
}
