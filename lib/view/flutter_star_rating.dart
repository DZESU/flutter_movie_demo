library flutter_star_rating;

import 'dart:math';
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final StarConfig starConfig;
  final double rating;
  final double spaceBetween;
  final Function onChangeRating;

  StarRating({this.starConfig = const StarConfig(), this.rating = 0.0, this.spaceBetween = 10.0, this.onChangeRating});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 0; i < 5; i++) {
      double fillFactor = i > widget.rating ? 0.0 : widget.rating - i;
      if (fillFactor > 1.0) fillFactor = 1.0;

      Widget star = Container(
        height: widget.starConfig.size,
        width: widget.starConfig.size,
        child: _Star(
          config: widget.starConfig,
          fillFactor: fillFactor,
        ),
      );

      if (widget.onChangeRating != null) {
        star = GestureDetector(
          child: star,
          onTap: () {
            widget.onChangeRating(i + 1);
          },
        );
      }

      //space between stars
      if (i > 0 && widget.spaceBetween > 0) {
        stars.add(SizedBox(width: widget.spaceBetween));
      }

      stars.add(star);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: stars,
    );
  }
}

class _Star extends StatelessWidget {
  final StarConfig config;
  final double fillFactor;

  _Star({this.config, this.fillFactor = 0}) : assert(fillFactor == null || fillFactor >= 0.0);

  @override
  Widget build(BuildContext context) {
    List<Widget> shapes = [];
    Widget empty = Align(
      alignment: Alignment.centerRight,
      child: ClipRect(
        child: Align(
          alignment: Alignment.centerRight,
          widthFactor: 1.0 - fillFactor,
          child: CustomPaint(
            painter: _StarPainter(
              strokeWidth: config.strokeWidth,
              raysCount: config.raysCount,
              fillColor: config.emptyColor,
              strokeColor: config.strokeColor,
            ),
            child: Container(),
          ),
        ),
      ),
    );
    shapes.add(empty);

    if (fillFactor > 0) {
      Widget fill = ClipRect(
        child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: fillFactor,
          child: CustomPaint(
            painter: _StarPainter(
              strokeWidth: config.strokeWidth,
              raysCount: config.raysCount,
              fillColor: config.fillColor,
              strokeColor: config.strokeColor,
            ),
            child: Container(),
          ),
        ),
      );
      shapes.add(fill);
    }

    return Stack(
      children: shapes,
    );
  }
}

class _Coordinate {
  final double x;
  final double y;

  _Coordinate(this.x, this.y);
}

class StarConfig {
  final double strokeWidth;
  final Color fillColor;
  final Color strokeColor;
  final int raysCount;
  final Color emptyColor;
  final double size;

  const StarConfig(
      {this.fillColor = Colors.yellow,
      this.strokeColor = Colors.black,
      this.strokeWidth = 1.0,
      this.raysCount = 5,
      this.emptyColor = Colors.white,
      this.size = 50.0});
}

class _StarPainter extends CustomPainter {
  final double strokeWidth;
  final int raysCount;
  final Color fillColor;
  final Color strokeColor;
  final Color circleColor;

  _StarPainter({
    this.strokeWidth,
    this.raysCount,
    this.fillColor = Colors.yellow,
    this.strokeColor = Colors.black,
    this.circleColor = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    double radius = min(size.width, size.height) / 2;
    _drawCircle(canvas, center, radius);

    final double strokeRadius = radius - strokeWidth;

    List<List<int>> chains = _indexChains(raysCount);

    List<double> radiansList = _radiansList(raysCount);
    List<Offset> strokeOffsets = _strokeOffsets(center, strokeRadius, radiansList);
    List<Offset> fillOffsets = _strokeOffsets(center, radius - strokeWidth * 2, radiansList);

    _drawStarStroke(canvas, strokeColor, strokeOffsets, chains);
    _drawStarFill(canvas, fillColor, fillOffsets, chains);
  }

  _drawCircle(Canvas canvas, Offset center, double radius) {
    final paint = Paint();
    paint.color = circleColor;
    canvas.drawCircle(center, radius, paint);
  }

  List<double> _radiansList(int raysCount) {
    double radiansStep = 2 * pi / raysCount;
    List<double> radiansList = [];
    for (int i = 0; i < raysCount; i++) {
      radiansList.add(radiansStep * i - pi / 2);
    }
    return radiansList;
  }

  List<Offset> _strokeOffsets(Offset center, strokeRadius, List<double> radiansList) {
    //list of coordinates
    List<_Coordinate> coordinates = radiansList.map((double radians) {
      return _circleCoordinate(strokeRadius, radians);
    }).toList();

    //list of canvas offsets
    List<Offset> strokeOffsets = coordinates
        .map((_Coordinate coordinate) => Offset(coordinate.x + center.dx, coordinate.y + center.dy))
        .toList();

    return strokeOffsets;
  }

  Path _path(List<Offset> offsets, List<int> chain) {
    // create a path
    Path path = Path();
    path.moveTo(offsets[chain[0]].dx, offsets[chain[0]].dy);
    chain.sublist(1).forEach((index) {
      Offset offset = offsets[index];
      path.lineTo(offset.dx, offset.dy);
    });

    path.close();
    return path;
  }

  _drawStarStroke(canvas, Color color, List<Offset> offsets, List<List<int>> chains) {
    final paint = Paint();
    paint.color = color;
    paint.strokeWidth = strokeWidth;
    paint.style = PaintingStyle.stroke;
    paint.strokeJoin = StrokeJoin.round;

    chains.forEach((List<int> chain) {
      Path path = _path(offsets, chain);
      canvas.drawPath(path, paint);
    });
  }

  _drawStarFill(canvas, Color color, List<Offset> offsets, List<List<int>> chains) {
    final pathPaint = Paint();
    pathPaint.color = color;
    pathPaint.style = PaintingStyle.fill;
    pathPaint.strokeJoin = StrokeJoin.round;

    chains.forEach((List<int> chain) {
      Path path = _path(offsets, chain);
      canvas.drawPath(path, pathPaint);
    });
  }

  List<int> _indexChain(int startIndex, int count) {
    List<int> chain = [startIndex];
    int currIndex = startIndex;

    int looper = 0;
    do {
      int nextIndex = currIndex + 2; //shifting
      if (nextIndex > count) {
        int delta = nextIndex - count;
        nextIndex = delta;
      }
      if (nextIndex == count) nextIndex = startIndex;

      chain.add(nextIndex);
      currIndex = nextIndex;

      looper++;
      if (looper > 100) break;
    } while (currIndex != startIndex);

    return chain;
  }

  bool _chainsExists(List<List<int>> chains, int num) {
    for (List<int> chain in chains) {
      if (chain.indexOf(num) > -1) return true;
    }
    return false;
  }

  bool _chainsContainsAll(List<List<int>> chains, count) {
    for (int i = 0; i < count; i++) {
      if (!_chainsExists(chains, i)) return false;
    }
    return true;
  }

  List<List<int>> _indexChains(count) {
    List<List<int>> chains = List<List<int>>();

    if (count <= 4) {
      chains = [List<int>.generate(count, (i) => i)];
    } else {
      int looper = 0;
      int startIndex = 0;
      while (!_chainsContainsAll(chains, count)) {
        chains.add(_indexChain(startIndex, count));
        startIndex++;
        if (looper > 3) break;
      }
    }

    return chains;
  }

  _Coordinate _circleCoordinate(double radius, double radians) {
    double x = radius * cos(radians);
    double y = radius * sin(radians);
    return _Coordinate(x, y);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
