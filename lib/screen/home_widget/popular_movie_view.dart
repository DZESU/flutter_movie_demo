import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_demo/constant.dart';
import 'package:movie_demo/model/movies/Result.dart';

import 'popular_movie.dart';

class PopularMovieView extends StatelessWidget {
  PopularMovieView({@required this.movies});

  List<Result> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Popular Movie",
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
//            height: 200,
            height: 180,
            margin: EdgeInsets.only(top: 20.0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: PopularMovie(
                        movie: movies.elementAt(index),
                      ));
                } else if (index == movies.length - 1){
                  return Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10.0),
                      child: PopularMovie(
                        movie: movies.elementAt(index),
                      ));
                }
                else {
                  return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: PopularMovie(
                        movie: movies.elementAt(index),
                      ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
