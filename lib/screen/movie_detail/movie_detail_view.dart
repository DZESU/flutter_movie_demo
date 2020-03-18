import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_demo/model/credit/Cast.dart';
import 'package:movie_demo/model/credit/Credit.dart';
import 'package:movie_demo/model/movie_detail/MovieDetail.dart';
import 'package:movie_demo/model/video/Video.dart';
import 'package:movie_demo/services/network_helper.dart';
import 'package:movie_demo/view/flutter_star_rating.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constant.dart';

class MovieDetailView extends StatefulWidget {
  MovieDetailView(this.movieId);

  int movieId;

  @override
  _MovieDetailViewState createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
//  VideoPlayerController _controller;
  YoutubePlayerController _controller;

  Future<MovieDetail> movieDetail;
  Future<Credit> credit;
  Future<Video> video;

  @override
  void initState() {
    print("init State");
    super.initState();

    print("Here is id: " + widget.movieId.toString());

    NetworkHelper networkHelper = NetworkHelper();
    String urlMovieDetail =
        kUrlMovieDetail.replaceAll("___Movie_id___", widget.movieId.toString());
    String urlCastMovie =
        kUrlMovieCredit.replaceAll("___Movie_id___", widget.movieId.toString());
    String urlVideoTrailer =
        kUrlMovieVideo.replaceAll("___Movie_id___", widget.movieId.toString());

    movieDetail = networkHelper.fetchMovieDetail(urlMovieDetail);
    credit = networkHelper.fetchMovieCast(urlCastMovie);
    video = networkHelper.fetchVideo(urlVideoTrailer);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: FutureBuilder<MovieDetail>(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String genres = "";
                for (int i = 0; i < snapshot.data.genres.length; i++) {
                  genres += snapshot.data.genres[i].name + ", ";
                }
                genres = genres.substring(0, genres.length - 2);
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0.0, 5.0),
                      // 10% of the width, so there are ten blinds.
                      colors: [
                        const Color(0xFFFBFBFD),
                        const Color(0xFFF1F4F7)
                      ],
                      // whitish to gray
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      FutureBuilder<Video>(
                        future: video,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data.results.isNotEmpty) {
                            _controller = YoutubePlayerController(
                              initialVideoId: snapshot.data.results[0].key,
                              flags: YoutubePlayerFlags(
                                mute: false,
                                autoPlay: true,
                                forceHideAnnotation: true,
                                loop: true,
                              ),
                            );
                            return YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: false,
                              topActions: <Widget>[
                                SizedBox(width: 8.0),
                                GestureDetector(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Icon(
                                  Icons.bookmark_border,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 28.0,
                                ),
                                Icon(
                                  Icons.launch,
                                  color: Colors.white,
                                ),
                              ],
                              bottomActions: <Widget>[
                                SizedBox(width: 14.0),
                                CurrentPosition(),
                                SizedBox(width: 8.0),
                                ProgressBar(
                                  isExpanded: true,
                                  colors: ProgressBarColors(
                                      playedColor: Color(0xFFDD3E3E),
                                      handleColor: Color(0xFFDD3E3E),
                                      bufferedColor: Colors.white60,
                                      backgroundColor: Colors.grey),
                                ),
                                RemainingDuration(),
                                FullScreenButton(),
                              ],
                              onReady: () {
                                print('Player is ready.');
                              },
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data.results.isEmpty) {
                            return Container(
                              color: Colors.black,
                              height: 200,
                              child: Center(
                                child: Text("No Video available.", style: genresWhite,),
                              ),
                            );
                          } else {
                            return Container(
                              color: Colors.black,
                              height: 200,
                              child: Center(
                                  child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )),
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            ListView(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 35, top: 15),
                                        child: Text(
                                          snapshot.data.title,
                                          style: headerBlack,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 35, top: 10),
                                        child: Text(
                                          genres,
                                          style: normalStyle,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 35, top: 10, bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            StarRating(
                                              spaceBetween: 3,
                                              rating:
                                                  snapshot.data.vote_average /
                                                      2,
                                              starConfig: StarConfig(
                                                size: 12,
                                                fillColor: Colors.black87,
                                                strokeWidth: 0,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                "${snapshot.data.vote_count} Ratings",
                                                style: normalStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TabBar(
                                        labelColor: Colors.pink,
                                        unselectedLabelColor: Colors.grey,
                                        indicatorColor: Colors.pink,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        tabs: [
                                          Tab(text: "Info"),
                                          Tab(text: "Reviews"),
                                          Tab(text: "Photos"),
                                          Tab(text: "Videos"),
                                        ],
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 20, left: 30),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8)),
                                          boxShadow: [
//                              BoxShadow(color: Color(0x22000000), blurRadius: 1)
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              "Details",
                                              style: TextStyle(
                                                  fontFamily: FontNameDefault,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Color(0xFF696880)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "${snapshot.data.runtime} mins",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF19222E),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                      "PG 13",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF19222E),
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 20, left: 30),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8)),
                                          boxShadow: [
//                              BoxShadow(color: Color(0x22000000), blurRadius: 1)
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              "Storyline",
                                              style: TextStyle(
                                                  fontFamily: FontNameDefault,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Color(0xFF696880)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Text(
                                                    snapshot.data.overview,
                                                    style: normalStyle,
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 20, left: 30, bottom: 90),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8)),
                                          boxShadow: [
//                              BoxShadow(color: Color(0x22000000), blurRadius: 1)
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              "Cast",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            FutureBuilder<Credit>(
                                              future: credit,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    height: 45,
                                                    child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot
                                                          .data.cast.length,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              Divider(),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 8),
                                                          width: 45,
                                                          child: CircleAvatar(
                                                            backgroundImage: NetworkImage(snapshot
                                                                        .data
                                                                        .cast[
                                                                            index]
                                                                        .profile_path !=
                                                                    null
                                                                ? kBaseImageUrl +
                                                                    snapshot
                                                                        .data
                                                                        .cast[
                                                                            index]
                                                                        .profile_path
                                                                : ""),
                                                            backgroundColor:
                                                                Colors.grey,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 350,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDD3E3E),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x66000000),
                                          spreadRadius: 1,
                                          blurRadius: 10),
                                    ],
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Watch Movie",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
