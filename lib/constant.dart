import 'package:flutter/material.dart';

const TextStyle headerBlack = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: Colors.black87,
    fontFamily: FontNameDefault);

const TextStyle headerWhite = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: Colors.white,
    fontFamily: FontNameDefault);

const TextStyle movieTitleWhite = TextStyle(
    fontFamily: FontNameDefault,
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);


const TextStyle movieTitleBlack = TextStyle(
    fontFamily: FontNameDefault,
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);


const TextStyle genresWhite = TextStyle(
    fontFamily: FontNameDefault,
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.w400);

const TextStyle genresBlack = TextStyle(
    fontFamily: FontNameDefault,
    color: Colors.black38,
    fontSize: 12.0,
    fontWeight: FontWeight.w400);

const TextStyle normalStyle = TextStyle(
    fontSize: 14.0, color: Color(0xFFB5B5B6), fontFamily: FontNameDefault);

const String FontNameDefault = 'Montserrat';

const String kProfileUrl =
    "https://s3.amazonaws.com/assets.materialup.com/users/pictures/000/344/652/preview/open-uri20180619-4-wgh4cn?1529419445";
const String kMovie1 =
    "https://i2.wp.com/tvtonight.com.au/wp-content/uploads/2019-11-15_1022.jpg?fit=520%2C350&ssl=1";
const String kMovie2 =
    "https://is2-ssl.mzstatic.com/image/thumb/Video114/v4/9c/be/28/9cbe2838-bc82-a090-c2d9-6d337e6c04f2/pr_source.lsr/1200x630.jpg";

const String MovieDetialRoute = '/movie_detial';
const String MainScreenRoute = '/';

const String kUrlNowPlaying =
    "https://api.themoviedb.org/3/movie/now_playing?api_key=5d967c7c335764f39b1efbe9c5de9760&language=en-US&page=1";
const String kUrlPopularMovie =
    "https://api.themoviedb.org/3/movie/popular?page=__page__&api_key=5d967c7c335764f39b1efbe9c5de9760";
const String kUrlTrendingMovie =
    "https://api.themoviedb.org/3/trending/movie/week?api_key=5d967c7c335764f39b1efbe9c5de9760";
const String kUrlTopActor =
    "https://api.themoviedb.org/3/person/popular?api_key=5d967c7c335764f39b1efbe9c5de9760&language=en-US&page=1";
const String kUrlMovieDetail =
    "https://api.themoviedb.org/3/movie/___Movie_id___?api_key=5d967c7c335764f39b1efbe9c5de9760&language=en-US";
const String kUrlMovieCredit =
    "https://api.themoviedb.org/3/movie/___Movie_id___/credits?api_key=5d967c7c335764f39b1efbe9c5de9760";
const String kUrlMovieVideo =
    "https://api.themoviedb.org/3/movie/___Movie_id___/videos?api_key=5d967c7c335764f39b1efbe9c5de9760&language=en-US";
const String kUrlSearchMovie =
    "https://api.themoviedb.org/3/search/movie?api_key=5d967c7c335764f39b1efbe9c5de9760&language=en-US&query=___query___&page=1&include_adult=false";
const String kBaseImageUrl = "https://image.tmdb.org/t/p/w500/";

const Map<int, String> kGenres = {
  28: "Action",
  12: "Adventure",
  16: "Animation",
  35: "Comedy",
  80: "Crime",
  99: "Documentary",
  18: "Drama",
  10751: "Family",
  14: "Fantasy",
  36: "History",
  27: "Horror",
  10402: "Music",
  9648: "Mystery",
  10749: "Romance",
  878: "Science Fiction",
  10770: "TV Movie",
  53: "Thriller",
  10752: "War",
  37: "Western",
};

/////Route Name
