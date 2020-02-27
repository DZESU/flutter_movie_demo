
class KnownFor {
    final String backdrop_path;
    final String first_air_date;
    final List<int> genre_ids;
    final int id;
    final String media_type;
    final String name;
    final List<String> origin_country;
    final String original_language;
    final String original_name;
    final String overview;
    final String poster_path;
    final double vote_average;
    final int vote_count;

    KnownFor({this.backdrop_path, this.first_air_date, this.genre_ids, this.id, this.media_type, this.name, this.origin_country, this.original_language, this.original_name, this.overview, this.poster_path, this.vote_average, this.vote_count});

    factory KnownFor.fromJson(Map<String, dynamic> json) {
        return KnownFor(
            backdrop_path: json['backdrop_path'], 
            first_air_date: json['first_air_date'], 
            genre_ids: json['genre_ids'] != null ? new List<int>.from(json['genre_ids']) : null, 
            id: json['id'], 
            media_type: json['media_type'], 
            name: json['name'], 
            origin_country: json['origin_country'] != null ? new List<String>.from(json['origin_country']) : null, 
            original_language: json['original_language'], 
            original_name: json['original_name'], 
            overview: json['overview'], 
            poster_path: json['poster_path'], 
            vote_average: json['vote_average'], 
            vote_count: json['vote_count'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['backdrop_path'] = this.backdrop_path;
        data['first_air_date'] = this.first_air_date;
        data['id'] = this.id;
        data['media_type'] = this.media_type;
        data['name'] = this.name;
        data['original_language'] = this.original_language;
        data['original_name'] = this.original_name;
        data['overview'] = this.overview;
        data['poster_path'] = this.poster_path;
        data['vote_average'] = this.vote_average;
        data['vote_count'] = this.vote_count;
        if (this.genre_ids != null) {
            data['genre_ids'] = this.genre_ids;
        }
        if (this.origin_country != null) {
            data['origin_country'] = this.origin_country;
        }
        return data;
    }
}