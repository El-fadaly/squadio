import 'package:squadio/business_logic/models/pooular_persons/person_model.dart';

class PopularPersonModel {
  num? page;
  List<PersonModel>? results;
  num? totalPages;
  num? totalResults;

  PopularPersonModel(
      {this.page, this.results, this.totalPages, this.totalResults});

  PopularPersonModel.fromJson(Map<dynamic, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <PersonModel>[];
      json['results'].forEach((v) {
        results!.add(PersonModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
