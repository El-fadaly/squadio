import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:squadio/business_logic/models/pooular_persons/images/images_model.dart';
import 'package:squadio/business_logic/models/pooular_persons/images/profile_model.dart';
import 'package:squadio/business_logic/models/pooular_persons/person_model.dart';
import 'package:squadio/business_logic/models/pooular_persons/popular_person_model.dart';
import 'package:squadio/business_logic/view_models/profile_view_model.dart';
import 'package:squadio/services/api_services/popular_people_api_service/popular_people_api_service.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_database_service.dart';
import 'package:squadio/services/dio_base_service/http_service.dart';
import 'package:squadio/services/remote_config_service/remote_config_service.dart';
import 'package:squadio/services/service_locator.dart';
import 'package:squadio/services/update_checker_service/update_checker_service.dart';
import 'package:squadio/views/resources/assets_manager.dart';
import 'package:squadio/views/screens/person_details_screen.dart';
import 'package:squadio/views/screens/profile_screen.dart';

class HomeViewModel with ChangeNotifier {
  var updateCheckerService = serviceLocator<UpdateCheckerService>();
  var remoteConfigService = serviceLocator<RemoteConfigService>();
  var apiService = serviceLocator<PopularPeopleApiService>();
  var databaseService = serviceLocator<PopularPeopleDatabaseService>();
  var httpService = HttpService();
  var hasMoreData = true;

  final scrollController = ScrollController();

  late PopularPersonModel popularPersonModel;
  late ImagesModel images;

  PersonModel selectedPerson = PersonModel();

  List<PersonModel> persons = [];
  List<ProfileModel> profiles = [];

  int page = 1;
  int imageIndexBanner = 0;
  int knownForIndexBanner = 0;

  bool isGrid = false;
  bool isLoadingPersonData = false;

  void initData(context) async {
    getInitialData();
    setScrollControllerListener(context);
  }

  void onClose() {
    print("on close ");
    scrollController.dispose();
  }

  Future<bool> needToUpDate() async {
    return updateCheckerService.updateCheck();
  }

  void setScrollControllerListener(context) {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          if (page < (popularPersonModel.totalPages ?? 0)) {
            getPopularPeopleFromService();
          } else {
            hasMoreData = false;
          }
          notifyListeners();
        }
      },
    );
  }

  String getGender({required num genderCode}) {
    if (genderCode >= 1 && genderCode <= 2) {
      return genderCode == 1 ? "female" : "male";
    } else {
      return "unknown";
    }
  }

  String getImageUrl(imageUrl) {
    return imageUrl != null
        ? 'http://image.tmdb.org/t/p/original' + imageUrl
        : ImageNetworkUrl.defaultPersonImage;
  }

  void getInitialData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      getPopularPeopleFromService();
    } else if (connectivityResult == ConnectivityResult.none) {
      getDataFromLocalDatabase();
    }
  }

  void getDataFromLocalDatabase() async {
    var json = await databaseService.getPopularPeopleFromDatabase();
    getPersonsDataFromJson(json);
  }

  void getPersonsDataFromJson(json) {
    if (json != null) {
      popularPersonModel = PopularPersonModel.fromJson(json);
      if (popularPersonModel.results?.isNotEmpty ?? false) {
        persons.addAll(popularPersonModel.results ?? []);
        notifyListeners();
      }
    }
  }

  void getPopularPeopleFromService() async {
    print("getting  data ");
    var response = await apiService.getPopularPeople(page);
    if (response.data != null) {
      getPersonsDataFromJson(response.data);
      if (page == 1) {
        databaseService.savePopularPeopleToDatabase(response.data);
      }
      page++;
    }
    notifyListeners();
  }

  Future<void> getPersonImagesFromService(context) async {
    EasyLoading.show();
    profiles = await apiService.getPersonImages(selectedPerson.id ?? 0);
    EasyLoading.dismiss();
    // notifyListeners();
  }

  void openPersonDetailsScreen(context, index) async {
    if (!isLoadingPersonData) {
      isLoadingPersonData = true;
      selectedPerson = persons[index];
      await getPersonImagesFromService(context);
      isLoadingPersonData = false;
      Navigator.pushNamed(context, PersonDetailsScreen.id);
    }
  }

  void onProfileTapped(context, index) {
    var profileModel = serviceLocator<ProfileViewModel>();
    profileModel.profile = profiles[index];
    profileModel.selectedPersonName = selectedPerson.name ?? "";
    Navigator.pushNamed(context, ProfileScreen.id);
  }

  void onImageCarouselPageChanged(index) {
    imageIndexBanner = index;
    notifyListeners();
  }

  void onKnownForCarouselPageChanged(index) {
    knownForIndexBanner = index;
    notifyListeners();
  }

  void changeProfilesLayoutShape() {
    isGrid = !isGrid;
    notifyListeners();
  }
}
