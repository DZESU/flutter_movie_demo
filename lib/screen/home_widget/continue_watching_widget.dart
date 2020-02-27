import 'package:flutter/material.dart';

import '../../constant.dart';

class ContinueWatching extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Continue Watching...",
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
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: ContinueWatchMovie());
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: ContinueWatchMovie());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContinueWatchMovie extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 130,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              kMovie2,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 130,
          child: Text(
            "Ant Man and the wasp",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
        ),
        Container(
          width: 130,
          child: Text(
            "Action Adventure",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.w400,
                fontSize: 10.0),
          ),
        ),

      ],
    );
  }
}
