import 'package:flutter/material.dart';
import 'package:movie_demo/constant.dart';
import 'package:movie_demo/screen/main_screen.dart';
import 'package:movie_demo/screen/movie_detail/movie_detail_view.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreenRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case MovieDetialRoute:
        int id = settings.arguments;
        return MaterialPageRoute(builder: (_) => MovieDetailView(id));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}