import 'package:sqflite/sqflite.dart';
import 'package:weather_app/modules/weather/data/models/city.model.dart';
import 'package:weather_app/modules/weather/data/sources/interfaces/i_city_local_data_source.dart';
import 'package:weather_app/utils/models/failure.model.dart';

const _citiesListKey = 'cities';

class CityLocalDataSource implements ICityLocalDataSource {
  Future<Database> _getDatabase() async {
    return await openDatabase(
      'weather.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
  CREATE TABLE cities (
    id TEXT PRIMARY KEY,
    city TEXT,
    lat REAL,
    lng REAL
  )
''',
        );
      },
    );
  }

  @override
  Future<void> addFavoriteCity(CityModel city) async {
    await fetchDataAndHandleErrors(() async {
      final db = await _getDatabase();
      await db.insert(
        _citiesListKey,
        city.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.close();
    });
  }

  @override
  Future<List<CityModel>> getFavoriteCities() async {
    return await fetchDataAndHandleErrors(() async {
      final db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(_citiesListKey);
      await db.close();
      return List.generate(maps.length, (i) => CityModel.fromDB(maps[i]));
    });
  }

  @override
  Future<void> removeFavoriteCity(CityModel city) async {
    await fetchDataAndHandleErrors(() async {
      final db = await _getDatabase();
      await db.delete(
        _citiesListKey,
        where: 'id = ?',
        whereArgs: [city.id],
      );
      await db.close();
    });
  }
}
