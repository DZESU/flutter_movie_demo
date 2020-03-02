
import 'package:flutter/material.dart';
import 'package:movie_demo/constant.dart';
import 'package:movie_demo/model/movies/Movies.dart';
import 'package:movie_demo/services/network_helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'now_showing_widget.dart';
import 'popular_movie_view.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Future<Movies> popularMovies;
  Future<Movies> nowShowingMovie;
  Future<Movies> trendingMovie;
//  RefreshController _refreshController = RefreshController(
//      initialRefresh: false);

  void _fetchData() {
    // monitor network fetch
    NetworkHelper networkHelper = NetworkHelper();
    popularMovies = networkHelper.fetchMovies(kUrlPopularMovie);
    nowShowingMovie = networkHelper.fetchMovies(kUrlNowPlaying);
    trendingMovie = networkHelper.fetchMovies(kUrlTrendingMovie);

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }


  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            FutureBuilder<Movies>(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PopularMovieView(movies: snapshot.data.results);
                } else {
                  return Container();
                }
              },
            ),
            FutureBuilder<Movies>(
              future: nowShowingMovie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NowShowingView(
                      headerTitle: "Now Showing",
                      movies: snapshot.data.results);
                } else {
                  return Container();
                }
              },
            ),
            FutureBuilder<Movies>(
              future: trendingMovie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NowShowingView(
                      headerTitle: "Trend of the Week",
                      movies: snapshot.data.results);
                } else {
                  return Container();
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
            )
          ],
        ),
        FutureBuilder(
          future: trendingMovie,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<Movies>(
//      future: movies,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          return ListView(
//            children: <Widget>[
//              PopularMovieView(movies: snapshot.data.results),
//              ContinueWatching(),
//              ContinueWatching(),
//            ],
//          );
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//
//        // By default, show a loading spinner.
//        return CircularProgressIndicator();
//      },
//    );
//  }
}
