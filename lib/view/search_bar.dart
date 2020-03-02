import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  Function onClose;

  SearchBar({this.onClose});

  @override
  _SearchBarState createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBar>{
  TextEditingController _controller;

  FocusNode _focusNode;

  bool showSearchView = false;


  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _controller.addListener(() {
      if(_controller.text.isEmpty){
        widget.onClose(false, _controller.text);
      }else{
        widget.onClose(true, _controller.text);
      }
    });
    _focusNode.addListener(() {
      print("view focus is "+ _focusNode.hasPrimaryFocus.toString());
//      widget.onClose(_focusNode.hasPrimaryFocus);
    });
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _controller.dispose();
    _focusNode.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300.0),
        border: Border.all(color: Colors.grey),
      ),
      height: 40.0,
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.grey),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                    focusColor: Colors.grey,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search for Movies",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _controller.clear();
                  _focusNode.unfocus();
                  widget.onClose(_focusNode.hasPrimaryFocus,"");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
