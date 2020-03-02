
import 'package:movie_demo/model/video/Result.dart';

class Video {
    int id;
    List<Result> results;

    Video({this.id, this.results});

    factory Video.fromJson(Map<String, dynamic> json) {
        return Video(
            id: json['id'], 
            results: json['results'] != null ? (json['results'] as List).map((i) => Result.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        if (this.results != null) {
            data['results'] = this.results.map((v) => v.toJson()).toList();
        }
        return data;
    }
}