import 'package:flutter/material.dart';
import 'package:movie_demo/model/movies/Movies.dart';
import 'package:movie_demo/model/movies/Result.dart';

import '../../constant.dart';

class GenresWidget extends StatelessWidget {


  GenresWidget({this.movies});
  List<Result> movies;


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
                    "Top Genres",
                    style: headerBlack,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      print("See all");
                    },
                    child: Text(
                      "See All",
                      style: normalStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: GenresMovie(movie: movies[index],));
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: GenresMovie(movie: movies[index],));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GenresMovie extends StatelessWidget {

  GenresMovie({this.movie});

  final Result movie;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 130,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                kBaseImageUrl+movie.poster_path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 130,
              height: 200,
              color: Color(0x66000000),
            ),
          ),
          Text(
            kGenres[movie.genre_ids[0]],
            style: headerWhite,
          )
        ],
      ),
    );
  }
}
