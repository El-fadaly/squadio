import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_database_service.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:path/path.dart';

class PopularPeopleSqfLiteService implements PopularPeopleDatabaseService {
  var database;
  PopularPeopleSqfLiteService() {
    initDatabase();
  }
  initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), AppConstants.dataBaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE ${AppConstants.dataBaseTableName} (id INTEGER PRIMARY KEY, json TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future getPopularPeopleFromDatabase() async {
    try {
      await initDatabase();
      final List<Map<String, dynamic>> persons =
          await database.query(AppConstants.dataBaseTableName);

      if (persons.isNotEmpty) {
        var map = jsonDecode(persons[0]['json']);
        return map;
      }
      return null;
    } catch (e) {
      print("excpetion in getting  data  form database  $e");
    }
  }

  @override
  Future<void> savePopularPeopleToDatabase(popularPersonJson) async {
    try {
      var json = jsonEncode(popularPersonJson);
      await database.transaction((txn) async {
        int id2 = await txn.rawInsert(
            'INSERT INTO ${AppConstants.dataBaseTableName}(id, json) VALUES(?, ?)',
            [0, json]);
      });
    } catch (e) {
      print("excpetion in saving  $e");
    }
  }
}
