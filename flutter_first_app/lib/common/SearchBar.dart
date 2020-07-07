import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  bool isEmpty;
  TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.search,
            enableInteractiveSelection: false,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: "Where you are going ?",
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                suffixIcon: IconButton(
                  hoverColor: Colors.black,
                  padding: EdgeInsets.zero,
                  iconSize: 18.0,
                  color: Colors.black54,
                  onPressed: onIconClick,
                  icon: isEmpty ? Icon(Icons.search) : Icon(Icons.clear),
                )),
            keyboardType: TextInputType.text,
            controller: _controller,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TextEditingController();
    _controller.addListener(listener);
    isEmpty = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller = null;
    isEmpty = null;
    super.dispose();
  }

  void listener() {
    if (_controller.text.isNotEmpty) {
      setState(() => isEmpty = false);
    } else {
      setState(() => isEmpty = true);
    }
  }

  void onIconClick() {
    _controller.clear();
  }
}
