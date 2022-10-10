import 'package:squadio/business_logic/models/pooular_persons/known_for_model.dart';
import 'package:squadio/views/resources/assets_manager.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:squadio/views/resources/strings_manager.dart';

class PersonModel {
  bool? adult;
  num? gender;
  num? id;
  List<KnownForModel>? knownFor;
  String? knownForDepartment;
  String? name;
  num? popularity;
  String? profilePath;

  PersonModel({
    this.adult,
    this.gender,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
  });

  PersonModel.fromJson(Map<dynamic, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    if (json['known_for'] != null) {
      knownFor = <KnownForModel>[];
      json['known_for'].forEach((v) {
        knownFor!.add(KnownForModel.fromJson(v));
      });
    }
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    if (knownFor != null) {
      data['known_for'] = knownFor!.map((v) => v.toJson()).toList();
    }
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    return data;
  }

  String get getKnownForDepartment =>
      knownForDepartment ?? AppStrings.defaultEmptyString;

  String get getName => name ?? AppStrings.defaultEmptyString;
  String get getImageUrl => profilePath != null
      ? AppConstants.imageDetailsUrl + "$profilePath"
      : ImageNetworkUrl.defaultPersonImage;

  String get getGender {
    if (gender != null) {
      if (gender! >= 1 && gender! <= 2) {
        return gender == 1 ? "female" : "male";
      } else {
        return "unknown";
      }
    } else {
      return "unknown";
    }
  }

  String get getPopularity => (popularity ?? 0).toString();
}
