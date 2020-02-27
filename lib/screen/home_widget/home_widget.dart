import 'package:flutter/material.dart';
import 'package:movie_demo/model/Movies.dart';
import 'package:movie_demo/services/network_helper.dart';

import '../../constant.dart';
import 'continue_watching_widget.dart';
import 'recently_add_view.dart';

class HomeWidget extends StatelessWidget {
  Movies movies;
  void getData() async{

    NetworkHelper networkHelper = NetworkHelper(kUrlRecentlyAdded);
    var moviesData = await networkHelper.getData();
    movies = Movies.fromJson(moviesData);
    print(movies);
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        RecentlyAddedView(),
        ContinueWatching(),
        ContinueWatching(),
      ],
    );
  }
}
