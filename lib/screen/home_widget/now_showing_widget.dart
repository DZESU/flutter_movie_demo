import 'package:flutter/material.dart';
import 'package:movie_demo/model/movies/Result.dart';

import '../../constant.dart';

class NowShowingView extends StatelessWidget {
  NowShowingView({this.headerTitle, this.movies});

  final List<Result> movies;
  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    headerTitle,
                    style: headerBlack,
                  ),
                ),
                Expanded(
                  child: Text(
                    "See All",
                    style: normalStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: NowShowingMovie(
                      movie: movies[index],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: NowShowingMovie(
                      movie: movies[index],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NowShowingMovie extends StatelessWidget {
  NowShowingMovie({@required this.movie});

  final Result movie;

  @override
  Widget build(BuildContext context) {
    String genres = "";
    for (int i = 0; i < movie.genre_ids.length; i++) {
      genres += kGenres[movie.genre_ids[i]] + ", ";
    }
    genres = genres.substring(0,genres.length-2);
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, MovieDetialRoute,arguments: movie.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 130,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                kBaseImageUrl + movie.poster_path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 130,
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: movieTitleBlack,
            ),
          ),
          Container(
            width: 130,
            child: Text(
              genres,
              overflow: TextOverflow.ellipsis,
              style: genresBlack,
            ),
          ),
        ],
      ),
    );
  }
}
