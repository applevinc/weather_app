import 'package:weather_app/domain/entities/city.dart';

abstract class ICityRepository {
  Future<List<City>> getAll();
}
