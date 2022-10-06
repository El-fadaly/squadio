class AppConstants {
  static const int gridCrossAxisCount = 2;
  static const int imageCarouselAutoPlayAnimationDuration = 1500;
  static const int knownForCarouselAutoPlayAnimationDuration = 3000;
  static const int sliderAnimationTime = 400;

  static const bool carouselAutPlay = true;

  static const double imageCarouselSliderViewPortFraction = 0.8;
  static const double knownForCarouselSliderViewPortFraction = 0.65;

  static const String moviesDatabaseApiKey = '3a80d71040a7358d19db911820071fb2';
  static const String baseUrl = 'http://api.themoviedb.org/3/';
  static const String popularPeople = baseUrl + 'person/popular';
  static const String person = baseUrl + 'person/';
  static const String imageDetailsUrl = "http://image.tmdb.org/t/p/original";
  static const String dataBaseKey = "popularPersonResponse";
  static const String dataBaseBoxName = 'dataBox';
  static const String dataBaseName = 'dataBox.db';
  static const String dataBaseTableName = 'movieDatabase';

  static const String remoteConfigKey = "enforced_min_version";

  static const String playStoreLink =
      "https://play.google.com/store/apps/details?id=com.example.squadio.squadio";
  static const String appStoreLink =
      "market://details?id=com.example.squadio.squadio";
}
