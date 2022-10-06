import 'package:firebase_core/firebase_core.dart';
import 'package:squadio/business_logic/view_models/app_update_view_model.dart';
import 'package:squadio/business_logic/view_models/home_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:squadio/business_logic/view_models/profile_view_model.dart';
import 'package:squadio/services/api_services/popular_people_api_service/popular_people_api_service.dart';
import 'package:squadio/services/api_services/popular_people_api_service/popular_people_dio_service.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_database_service.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_hive_service.dart';
import 'package:squadio/services/database_services/popular_people_database_service/popular_people_sqflite_service.dart';
import 'package:squadio/services/remote_config_service/remote_config_service.dart';
import 'package:squadio/services/update_checker_service/current_app_version_service.dart';
import 'package:squadio/services/update_checker_service/update_checker_service.dart';

GetIt serviceLocator = GetIt.instance;

Future setupServiceLocator() async {
  await Firebase.initializeApp();

  serviceLocator.registerLazySingleton<PopularPeopleApiService>(
    () => PopularPeopleDioService(),
  );
  // serviceLocator.registerLazySingleton<PopularPeopleDatabaseService>(
  //   () => PopularPeopleHiveService(),
  // );
  serviceLocator.registerLazySingleton<PopularPeopleDatabaseService>(
    () => PopularPeopleSqfLiteService(),
  );

  serviceLocator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  serviceLocator
      .registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
  serviceLocator
      .registerLazySingleton<AppUpdateViewModel>(() => AppUpdateViewModel());

  serviceLocator
      .registerLazySingleton<RemoteConfigService>(() => RemoteConfigService());
  serviceLocator.registerLazySingleton<CurrentAppVersionService>(
      () => CurrentAppVersionService());
  serviceLocator.registerLazySingleton<UpdateCheckerService>(
      () => UpdateCheckerService());
}
