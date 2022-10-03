import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:squadio/business_logic/models/pooular_persons/popular_person_model.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_database_service.dart';
import 'package:squadio/views/resources/constants_manager.dart';

class PopularPeopleHiveService implements PopularPeopleDatabaseService {
  @override
  Future<dynamic> getPopularPeopleFromDatabase() async {
    var popularPerson = PopularPersonModel();
    print("in get from local service   ");
    try {
      var box = await Hive.openBox(AppConstants.dataBaseBoxName);
      var dataFromDataBase = box.get(AppConstants.dataBaseKey);
      // popularPerson = PopularPersonModel.fromJson(dataFromDataBase);
      print("data  $dataFromDataBase");
      print("data type  at  sevice  ${dataFromDataBase.runtimeType}");
      return dataFromDataBase;
    } catch (e) {
      print("exception in getting  data  from database  :  $e");
    }
    return "";
  }

  @override
  Future<void> savePopularPeopleToDatabase(dynamic popularPersonJson) async {
    try {
      print("saving  to database  ");
      var box = await Hive.openBox(AppConstants.dataBaseBoxName);
      await box.put(AppConstants.dataBaseKey, popularPersonJson);
    } catch (e) {
      print("exception in saving  data  to database  :  $e");
    }
  }
}
