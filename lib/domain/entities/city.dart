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
}
