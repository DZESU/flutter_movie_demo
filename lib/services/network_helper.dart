import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_demo/model/movies/Movies.dart';
import 'package:movie_demo/model/people/People.dart';

class NetworkHelper{


  Future<Movies> fetchMovies(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      print(response.body);
      return Movies.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
  Future<People> fetchPeople(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      print(response.body);
      return People.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
}