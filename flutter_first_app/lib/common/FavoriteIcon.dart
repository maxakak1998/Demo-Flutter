import 'dart:developer';

import 'package:first_app/Home/HomeBloc/Bloc.dart';
import 'package:first_app/Home/HomeBloc/State.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DimensionHelper.dart';

class FavoriteIcon extends StatelessWidget {
  final int iconValue;
  final num _sizeIconValue = 12.0;
  const FavoriteIcon({Key key, this.iconValue = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Icon(
          Icons.favorite,
          color: Colors.white,
          size: 28.0,
        ),
        Container(
          height: 17.0,
          width: 17.0,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Center(
            child: Text(
              iconValue.toString(),
              style: TextStyle(fontSize: iconValue > 99 ? 8.0 : _sizeIconValue),
            ),
          ),
        )
      ],
    );
  }
}
