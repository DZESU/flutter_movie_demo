import 'KnownFor.dart';


class Result {
    final bool adult;
    final int gender;
    final int id;
    final List<KnownFor> known_for;
    final String known_for_department;
    final String name;
    final double popularity;
    final String profile_path;

    Result({this.adult, this.gender, this.id, this.known_for, this.known_for_department, this.name, this.popularity, this.profile_path});

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            adult: json['adult'], 
            gender: json['gender'], 
            id: json['id'], 
            known_for: json['known_for'] != null ? (json['known_for'] as List).map((i) => KnownFor.fromJson(i)).toList() : null, 
            known_for_department: json['known_for_department'], 
            name: json['name'], 
            popularity: json['popularity'], 
            profile_path: json['profile_path'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['adult'] = this.adult;
        data['gender'] = this.gender;
        data['id'] = this.id;
        data['known_for_department'] = this.known_for_department;
        data['name'] = this.name;
        data['popularity'] = this.popularity;
        data['profile_path'] = this.profile_path;
        if (this.known_for != null) {
            data['known_for'] = this.known_for.map((v) => v.toJson()).toList();
        }
        return data;
    }
}