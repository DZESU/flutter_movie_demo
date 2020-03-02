import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_demo/constant.dart';
import 'package:movie_demo/model/movies/Movies.dart';
import 'package:movie_demo/screen/browse_widget/browse_widget.dart';
import 'package:movie_demo/screen/search_widget/search_widget.dart';
import 'package:movie_demo/services/network_helper.dart';
import 'package:movie_demo/view/search_bar.dart';

import 'home_widget/home_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _showSearch = false;
  String _text = "";
  StreamController _streamController;
  NetworkHelper networkHelper = NetworkHelper();

  List<Widget> navView = <Widget>[
    HomeWidget(),
    BrowseWidget(),
    HomeWidget(),
    HomeWidget(),
  ];

  List<String> titleBar = ["Muvies", "Browse", "Saved", "Account"];

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            width: 58,
            child: CircleAvatar(
              backgroundImage: NetworkImage(kProfileUrl),
              backgroundColor: Colors.grey,
            ),
          ),
        ],
        elevation: 0.0,
        title: Text(
          titleBar.elementAt(_selectedIndex),
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.0, 5.0),
              // 10% of the width, so there are ten blinds.
              colors: [const Color(0xFFFEFEFF), const Color(0xFFF1F3F7)],
              // whitish to gray
            ),
          ),
          child: Column(
            children: <Widget>[
              SearchBar(
                onClose: (isFocus, text) {
                  setState(() {
                    print("set state called");
                    _showSearch = isFocus;
                    _text = text;
                  });
                },
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    navView.elementAt(_selectedIndex),
                    FutureBuilder<Movies>(
                        future: searchMovie(_text),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SearchWidget(snapshot.data.results);
                          } else if(_showSearch){
                            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
                          }else {
                            return Container();
                          }
                        }),
//                    Visibility(
//                      child: SearchWidget(_text),
//                      visible: _showSearch,
//                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: !_showSearch,
        child: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.youtube),
                title: Text('Browse'),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bookmark),
                title: Text('Saved'),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user),
                title: Text('Account'),
              ),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.grey[400],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      print(value);
      _selectedIndex = value;
    });
  }

  Future<Movies> searchMovie(String query) {
    String urlSearch = kUrlSearchMovie.replaceAll("___query___", query);
    return networkHelper.fetchSearchMovie(urlSearch);
  }
}
