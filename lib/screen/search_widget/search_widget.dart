import 'package:flutter/material.dart';
import 'package:movie_demo/view/flutter_star_rating.dart';

import '../../constant.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Search Result",
                  style: headerStyle,
                ),
              ),
              Expanded(
                child: Text(
                  "Filtter by",
                  style: normalStyle,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              SearchResult(),
              SearchResult(),
              SearchResult(),
              SearchResult(),
            ],
          ),
        )
      ],
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 6.0, color: Color(0x33000000))],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              height: 200.0,
              width: 130.0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                child: Image.network(
                  kMovie2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Deadpool 2 (2018)",
                      style: headerStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      "Action, Comedy",
                      style: normalStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: StarRating(
                      rating: 3,
                      starConfig: StarConfig(
                        size: 15,
                        fillColor: Colors.black87,
                        strokeWidth: 0,
                      ),
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.only(top: 8),
                    child: Text(
                      "Caption",
                      style: normalStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
