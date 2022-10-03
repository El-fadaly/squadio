import 'package:squadio/business_logic/models/pooular_persons/known_for_model.dart';

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
}
