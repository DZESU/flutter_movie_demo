import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_demo/model/credit/Cast.dart';
import 'package:movie_demo/model/credit/Credit.dart';
import 'package:movie_demo/model/movie_detail/MovieDetail.dart';
import 'package:movie_demo/model/movies/Movies.dart';
import 'package:movie_demo/model/people/People.dart';
import 'package:movie_demo/model/video/Video.dart';

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
      print("This is the body***** : "+response.body);
      People people = People.fromJson(json.decode(response.body));
      print("People lenght: "+people.results.length.toString());
      return people;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
  Future<MovieDetail> fetchMovieDetail(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      print("This is the body***** : "+response.body);
      MovieDetail movieDetail = MovieDetail.fromJson(json.decode(response.body));
      return movieDetail;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
  Future<Credit> fetchMovieCast(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      print("This is the body***** : "+response.body);
      Credit credit = Credit.fromJson(json.decode(response.body));
      return credit;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
  Future<Video> fetchVideo(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      print("This is the body***** : "+response.body);
      Video video = Video.fromJson(json.decode(response.body));
      return video;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
  Future<Movies> fetchSearchMovie(String url) async {
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
}