import 'package:squadio/business_logic/models/pooular_persons/popular_person_model.dart';

abstract class PopularPeopleDatabaseService {
  Future<void> savePopularPeopleToDatabase(dynamic popularPersonJson);
  Future<dynamic> getPopularPeopleFromDatabase();
}
