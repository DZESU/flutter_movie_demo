import 'package:flutter/material.dart';
import 'package:movie_demo/constant.dart';
import 'package:movie_demo/screen/main_screen.dart';
import 'package:movie_demo/screen/movie_detail/movie_detail.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreenRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case MovieDetialRoute:
        return MaterialPageRoute(builder: (_) => MovieDetail());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}