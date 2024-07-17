import 'package:weather_app/modules/weather/data/models/location.model.dart';

class Location {
  final double longitude;
  final double latitude;

  Location({
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromModel(LocationModel model) {
    return Location(
      longitude: model.longitude,
      latitude: model.latitude,
    );
  }
}
