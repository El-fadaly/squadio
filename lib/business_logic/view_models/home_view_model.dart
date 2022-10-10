import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  var hasMoreData = true;

  final scrollController = ScrollController();

  late PopularPersonModel popularPersonModel;

  PersonModel selectedPerson = PersonModel();

  List<PersonModel> persons = [];
  List<ProfileModel> profiles = [];

  int page = 1;
  bool isLoadingPersonData = false;

  /// home  screen functions
  void initData() async {
    getInitialData();
    setScrollControllerListener();
  }

  void onClose() {
    scrollController.dispose();
  }

  Future<bool> appNeedToUpDate() async {
    return updateCheckerService.checkForUpdate();
  }

  void setScrollControllerListener() {
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

  void getInitialData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      getPopularPeopleFromService();
    } else if (connectivityResult == ConnectivityResult.none) {
      getDataFromLocalDatabase();
    }
  }

  void getPopularPeopleFromService() async {
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

  void openPersonDetailsScreen(context, index) async {
    if (!isLoadingPersonData) {
      isLoadingPersonData = true;
      selectedPerson = persons[index];
      await getPersonImagesFromService();
      isLoadingPersonData = false;
      Navigator.pushNamed(context, PersonDetailsScreen.id);
    }
  }

  /// person details  screen

  int imageIndexBanner = 0;
  int knownForIndexBanner = 0;

  bool isGrid = false;

  Future<void> getPersonImagesFromService() async {
    EasyLoading.show();
    profiles = await apiService.getPersonImages(selectedPerson.id ?? 0);
    EasyLoading.dismiss();
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

  void onProfileTapped(context, index) {
    var profileModel = serviceLocator<ProfileViewModel>();
    profileModel.profile = profiles[index];
    profileModel.selectedPersonName = selectedPerson.name ?? "";
    Navigator.pushNamed(context, ProfileScreen.id);
  }
}
