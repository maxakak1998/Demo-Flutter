import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final num iconSize;

  const ProfileIcon({Key key, this.iconSize=28.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Icon(Icons.account_circle, size: iconSize);
  }
}