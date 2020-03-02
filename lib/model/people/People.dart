import 'package:movie_demo/model/people/Result.dart';


class People {
    List<Result> results;

    People({this.results});

    factory People.fromJson(Map<String, dynamic> json) {
        return People(
            results: json['results'] != null ? (json['results'] as List).map((i) => Result.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.results != null) {
            data['results'] = this.results.map((v) => v.toJson()).toList();
        }
        return data;
    }
}