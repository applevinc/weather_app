import 'package:weather_app/modules/weather/domain/entities/city.dart';

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
}
