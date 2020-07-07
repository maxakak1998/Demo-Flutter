import 'dart:developer';

import 'package:first_app/Home/ItemCheckBox.dart';
import 'package:first_app/common/Country.dart';
import 'package:first_app/common/CustomCheckBox.dart';
import 'package:first_app/common/DimensionHelper.dart';
import 'package:first_app/common/Tour.dart';
import 'package:flutter/material.dart';

class ItemCountry extends StatelessWidget {
  final Country country;
  final double containerHeight;
  ItemCountry({Key key, @required this.containerHeight, @required this.country})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black45, width: 0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            width: dimensionHelper(context).width * 0.5,
            height: containerHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                country.getImageUrl,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext ctx, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  country.getGame,
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  country.getAvailableTour.toString() + " tours",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
