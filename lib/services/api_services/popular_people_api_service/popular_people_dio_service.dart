import 'package:squadio/business_logic/models/pooular_persons/images/images_model.dart';
import 'package:squadio/business_logic/models/pooular_persons/images/profile_model.dart';
import 'package:squadio/business_logic/models/pooular_persons/popular_person_model.dart';
import 'package:squadio/services/api_services/popular_people_api_service/popular_people_api_service.dart';
import 'package:squadio/services/dio_base_service/http_service.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:dio/dio.dart' as dio;

class PopularPeopleDioService implements PopularPeopleApiService {
  HttpService httpService = HttpService();
  var popularPersonModel = PopularPersonModel();
  var images = ImagesModel();
  var profiles = <ProfileModel>[];

  PopularPeopleDioService() {
    httpService.init();
  }

  @override
  Future<dynamic> getPopularPeople(int page) async {
    try {
      final response = await httpService.request(
        url: AppConstants.popularPeople +
            '?api_key=' +
            AppConstants.moviesDatabaseApiKey +
            '&page=$page',
        method: Method.GET,
      );
      if (response != null) {
        return response;
      }
    } catch (e) {
      print("exception in getting  popular  persons $e");
    }
    return "";
  }

  @override
  Future<List<ProfileModel>> getPersonImages(num personId) async {
    try {
      final response = await httpService.request(
        url: AppConstants.person +
            '/$personId/images' +
            '?api_key=' +
            AppConstants.moviesDatabaseApiKey,
        method: Method.GET,
      );
      if (response != null) {
        images = ImagesModel.fromJson(response.data);
        profiles = images.profiles ?? [];
        print('total images  = ' + profiles.length.toString());
        return profiles;
      }
    } catch (e) {
      print("exception in getting  popular  persons images $e");
    }
    return profiles;
  }
}
