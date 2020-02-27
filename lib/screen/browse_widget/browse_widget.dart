import 'package:flutter/material.dart';
import 'package:movie_demo/screen/home_widget/continue_watching_widget.dart';
import 'package:movie_demo/screen/home_widget/recent_movie.dart';

import '../../constant.dart';
import 'genres_widget.dart';

class BrowseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ContinueWatching(),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Top Actors",
                        style: headerStyle,
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
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          width: 100,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(kProfileUrl),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          width: 100,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(kProfileUrl),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              GenresWidget(),
            ],
          ),
        )
      ],
    );
  }
}
