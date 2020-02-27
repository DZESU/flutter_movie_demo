
import 'package:flutter/material.dart';
import 'package:movie_demo/model/movies/Result.dart';
import 'package:movie_demo/screen/movie_detail/movie_detail.dart';

import '../../constant.dart';

class PopularMovie extends StatelessWidget {


  PopularMovie({@required this.movie});
  final Result movie;


  @override
  Widget build(BuildContext context) {
    String genres = "";
    for(int i = 0; i < movie.genre_ids.length; i++){
      genres += kGenres[movie.genre_ids[i]]+ ", ";
    }
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, MovieDetialRoute);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 360,
              child: Image.network(
                kBaseImageUrl+movie.backdrop_path,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 360,
                height: 130,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.0, 1.5),
//                    end: Alignment.bottomCenter,
                    // 10% of the width, so there are ten blinds.
                    colors: [const Color(0x00999999), const Color(0xEE000000)],
                    // whitish to gray
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ),
                  Text(
                    genres,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

