import 'package:squadio/views/resources/assets/assets_manager.dart';
import 'package:squadio/views/resources/constants_manager.dart';

class KnownForModel {
  bool? adult;
  String? backdropPath;
  List<num>? genreIds;
  int? id;
  String? mediaType;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;
  String? firstAirDate;
  String? name;
  List<String>? originCountry;
  String? originalName;

  KnownForModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalName,
  });

  KnownForModel.fromJson(Map<dynamic, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];

    id = json['id'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    firstAirDate = json['first_air_date'];
    name = json['name'];

    originalName = json['original_name'];
    if (json['genre_ids'] != null) {
      genreIds = json['genre_ids'].cast<num>();
    }
    if (json['origin_country'] != null) {
      originCountry = json['origin_country'].cast<String>();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['media_type'] = mediaType;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['first_air_date'] = firstAirDate;
    data['name'] = name;
    data['origin_country'] = originCountry;
    data['original_name'] = originalName;
    return data;
  }

  String get getImageUrl => posterPath != null
      ? AppConstants.imageDetailsUrl + "$posterPath"
      : ImageNetworkUrl.defaultPersonImage;
  String get getName => originalTitle ?? originalName ?? " ";

  double get getRating => (voteAverage ?? 0.0) / 2;
}
