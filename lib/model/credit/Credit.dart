
import 'package:movie_demo/model/credit/Cast.dart';
import 'package:movie_demo/model/credit/Crew.dart';

class Credit {
    List<Cast> cast;
    List<Crew> crew;
    int id;

    Credit({this.cast, this.crew, this.id});

    factory Credit.fromJson(Map<String, dynamic> json) {
        return Credit(
            cast: json['cast'] != null ? (json['cast'] as List).map((i) => Cast.fromJson(i)).toList() : null, 
            crew: json['crew'] != null ? (json['crew'] as List).map((i) => Crew.fromJson(i)).toList() : null, 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        if (this.cast != null) {
            data['cast'] = this.cast.map((v) => v.toJson()).toList();
        }
        if (this.crew != null) {
            data['crew'] = this.crew.map((v) => v.toJson()).toList();
        }
        return data;
    }
}