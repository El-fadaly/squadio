import 'package:squadio/business_logic/models/pooular_persons/images/profile_model.dart';
import 'package:squadio/business_logic/models/pooular_persons/popular_person_model.dart';

abstract class PopularPeopleApiService {
  Future<dynamic> getPopularPeople(int page);
  Future<List<ProfileModel>> getPersonImages(num personId);
}
