import 'package:flutter/material.dart';
import 'package:movie_demo/model/movies/Result.dart';
import 'package:movie_demo/view/flutter_star_rating.dart';

import '../../constant.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget(this.movies);

  List<Result> movies;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Search Result",
                    style: headerBlack,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Filtter by",
                    style: normalStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.movies.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return SearchResult(widget.movies[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: widget.movies.length)
                : Center(
                    child: Text("No Result found.",style: headerBlack,),
                  ),
          )
        ],
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  SearchResult(this.movie);

  Result movie;

  @override
  Widget build(BuildContext context) {
    String genres = "";
    for (int i = 0; i < movie.genre_ids.length; i++) {
      genres += kGenres[movie.genre_ids[i]] + ", ";
    }
    genres = genres.isEmpty ? "" : genres.substring(0, genres.length - 2);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieDetialRoute, arguments: movie.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 6.0, color: Color(0x33000000))],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                height: 200.0,
                width: 130.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  child: Image.network(
                    movie.poster_path != null
                        ? kBaseImageUrl + movie.poster_path
                        : kBaseImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        movie.title,
                        style: headerBlack,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        genres,
                        style: normalStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: StarRating(
                        rating: movie.vote_average / 2,
                        starConfig: StarConfig(
                          size: 13,
                          fillColor: Colors.black87,
                          strokeWidth: 0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        movie.overview,
                        style: normalStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
