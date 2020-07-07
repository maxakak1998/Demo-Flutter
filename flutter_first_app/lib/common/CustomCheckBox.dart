import 'dart:developer';

import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {

  final String title;

  CustomCheckBox({Key key, this.title = ""}) :super(key: key);

  CustomCheckBox.withTitle(this.title);

  @override
  _CustomCheckBoxState createState() {
    // TODO: implement createState
    return _CustomCheckBoxState();
  }

}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: isChecked,
          onChanged: (newValue) {
            setState((){
              isChecked = newValue;
            });
          }
        ),
        Text(widget.title,
          style: TextStyle(
            fontSize: 14
          ),
        )
      ],
    );
  }


    }