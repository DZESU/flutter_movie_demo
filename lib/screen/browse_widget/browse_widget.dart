import 'package:flutter/material.dart';
import 'package:movie_demo/model/movies/Movies.dart';
import 'package:movie_demo/model/people/People.dart';
import 'package:movie_demo/model/people/Result.dart';
import 'package:movie_demo/screen/home_widget/now_showing_widget.dart';
import 'package:movie_demo/services/network_helper.dart';

import '../../constant.dart';
import 'genres_widget.dart';

class BrowseWidget extends StatefulWidget {
  @override
  _BrowseWidgetState createState() => _BrowseWidgetState();
}

class _BrowseWidgetState extends State<BrowseWidget> {
  Future<Movies> popularMovies;
  Future<People> topActors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState BrowseWidgetState");
    _fetchData();
  }

  void _fetchData(){
    NetworkHelper networkHelper = NetworkHelper();
    popularMovies = networkHelper.fetchMovies(kUrlPopularMovie);
    topActors = networkHelper.fetchPeople(kUrlTopActor);
  }

  Future<void> _reloadData(){
    _fetchData();
    setState(() {});
    return Future.wait([popularMovies, topActors]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          onRefresh: _reloadData,
          child: ListView(
            children: <Widget>[
              FutureBuilder<Movies>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return NowShowingView(
                      headerTitle: "Popular Movie",
                      movies: snapshot.data.results,
                    );
                  } else {
                    return Center();
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: FutureBuilder<People>(
                  future: topActors,
                  builder: (context, snapshot) {
                    print("snapshot data: " + snapshot.data.toString());
                    if (snapshot.hasData) {
                      return ActorWidget(
                        people: snapshot.data.results,
                      );
                    } else {
                      return Center();
                    }
                  },
                ),
              ),
              FutureBuilder<Movies>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GenresWidget(
                      movies: snapshot.data.results,
                    );
                  } else {
                    return Center();
                  }
                },
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: popularMovies,
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
}

class ActorWidget extends StatelessWidget {
  ActorWidget({this.people});

  final List<Result> people;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Top Actors",
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
          margin: EdgeInsets.only(top: 20),
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: people.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        kBaseImageUrl + people[index].profile_path,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        kBaseImageUrl + people[index].profile_path,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
