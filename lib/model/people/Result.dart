import 'package:movie_demo/model/people/KnownFor.dart';


class Result {
    int gender;
    int id;
    String name;
    String profile_path;

    Result({this.gender, this.id, this.name, this.profile_path});

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            gender: json['gender'],
            id: json['id'], 
            name: json['name'],
            profile_path: json['profile_path'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['gender'] = this.gender;
        data['id'] = this.id;
        data['name'] = this.name;
        data['profile_path'] = this.profile_path;

        return data;
    }
}