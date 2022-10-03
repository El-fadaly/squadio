import 'package:squadio/business_logic/view_models/home_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:squadio/business_logic/view_models/profile_view_model.dart';
import 'package:squadio/services/api_services/popular_people_api_service/popular_people_api_service.dart';
import 'package:squadio/services/api_services/popular_people_api_service/popular_people_dio_service.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_database_service.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_hive_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<PopularPeopleApiService>(
    () => PopularPeopleDioService(),
  );
  serviceLocator.registerLazySingleton<PopularPeopleDatabaseService>(
    () => PopularPeopleHiveService(),
  );

  serviceLocator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  serviceLocator
      .registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
}
