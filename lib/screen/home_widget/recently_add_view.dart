import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_demo/constant.dart';
import 'package:movie_demo/model/Result.dart';

import 'recent_movie.dart';

class RecentlyAddedView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Recently Added",
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
            height: 200,
            margin: EdgeInsets.only(top: 20.0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: RecentedMovie());
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: RecentedMovie());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
