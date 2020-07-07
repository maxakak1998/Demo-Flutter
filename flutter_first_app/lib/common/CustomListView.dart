import 'package:first_app/Home/ItemPopularTour.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'ItemCountry.dart';
import 'Tour.dart';

enum ItemType { PopularTourType, CountryType }

class CustomListView extends StatelessWidget {
  final List<dynamic> dataList;
  final height, width;
  final Axis axis;
  final ItemType itemType;
  CustomListView(
      {Key key,
      @required this.itemType,
      @required this.dataList,
      @required this.height,
      this.axis = Axis.vertical,
      this.width = double.maxFinite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int dataLength = dataList.length;
    if (itemType == ItemType.PopularTourType) {
      return SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: axis,
          itemCount: dataLength,
          itemBuilder: (BuildContext context, int index) {
            return ItemPopularTour(
              index: index,
              tour: this.dataList[index],
              containerHeight: height,
            );
          },
        ),
      );
    } else if (itemType == ItemType.CountryType) {
      return SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: axis,
          itemCount: dataLength,
          itemBuilder: (BuildContext context, int index) {
            return ItemCountry(
              country: this.dataList[index],
              containerHeight: height,
            );
          },
        ),
      );
    }
    // TODO: implement build
  }
}
