
class KnownFor {
    bool adult;
    String backdrop_path;
    List<int> genre_ids;
    int id;
    String media_type;
    String original_language;
    String original_title;
    String overview;
    String poster_path;
    String release_date;
    String title;
    bool video;
    int vote_average;
    int vote_count;

    KnownFor({this.adult, this.backdrop_path, this.genre_ids, this.id, this.media_type, this.original_language, this.original_title, this.overview, this.poster_path, this.release_date, this.title, this.video, this.vote_average, this.vote_count});

    factory KnownFor.fromJson(Map<String, dynamic> json) {
        return KnownFor(
            adult: json['adult'], 
            backdrop_path: json['backdrop_path'], 
            genre_ids: json['genre_ids'] != null ? new List<int>.from(json['genre_ids']) : null, 
            id: json['id'], 
            media_type: json['media_type'], 
            original_language: json['original_language'], 
            original_title: json['original_title'], 
            overview: json['overview'], 
            poster_path: json['poster_path'], 
            release_date: json['release_date'], 
            title: json['title'], 
            video: json['video'], 
            vote_average: json['vote_average'], 
            vote_count: json['vote_count'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['adult'] = this.adult;
        data['backdrop_path'] = this.backdrop_path;
        data['id'] = this.id;
        data['media_type'] = this.media_type;
        data['original_language'] = this.original_language;
        data['original_title'] = this.original_title;
        data['overview'] = this.overview;
        data['poster_path'] = this.poster_path;
        data['release_date'] = this.release_date;
        data['title'] = this.title;
        data['video'] = this.video;
        data['vote_average'] = this.vote_average;
        data['vote_count'] = this.vote_count;
        if (this.genre_ids != null) {
            data['genre_ids'] = this.genre_ids;
        }
        return data;
    }
}