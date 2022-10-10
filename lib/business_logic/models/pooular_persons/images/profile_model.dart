import 'package:squadio/views/resources/assets_manager.dart';
import 'package:squadio/views/resources/constants_manager.dart';

class ProfileModel {
  double? aspectRatio;
  int? height;
  dynamic iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  ProfileModel(
      {this.aspectRatio,
      this.height,
      this.iso6391,
      this.filePath,
      this.voteAverage,
      this.voteCount,
      this.width});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }
  String get getImageUrl => filePath != null
      ? AppConstants.imageDetailsUrl + "$filePath"
      : ImageNetworkUrl.defaultPersonImage;

  double get getWidth => width?.toDouble() ?? double.infinity;
  double get getHeight => width?.toDouble() ?? double.infinity;
}
