import 'package:weather_app/data/models/city.model.dart';
import 'package:weather_app/data/models/location.model.dart';
import 'package:weather_app/domain/entities/location.dart';

class City {
  final String id;
  final String name;
  final Location location;

  City({
    required this.id,
    required this.name,
    required this.location,
  });

  factory City.fromModel(CityModel model) {
    return City(
      id: model.id,
      name: model.name,
      location: Location.fromModel(model.location as LocationModel),
    );
  }
}
