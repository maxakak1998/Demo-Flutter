import 'package:first_app/Home/ItemCheckBox.dart';
import 'package:first_app/common/CustomCheckBox.dart';
import 'package:first_app/common/DimensionHelper.dart';
import 'package:first_app/common/Tour.dart';
import 'package:flutter/material.dart';

class ItemPopularTour extends StatelessWidget {
  final Tour tour;
  final double containerHeight;
  final int index;
  ItemPopularTour(
      {Key key,
      this.index,
      @required this.containerHeight,
      @required this.tour})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Container(
                  width: dimensionHelper(context).width * 0.5,
                  height: containerHeight * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      tour.take["urlImage"],
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
                ItemCheckBox(
                  index: index,
                  tour: this.tour,
                )
              ],
            ),
            Expanded(
              child: Padding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      tour.take["location"],
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: <Widget>[
                        Text("${tour.take["totalPlace"]} places",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey),
                            textAlign: TextAlign.start),
                        SizedBox(width: 8.0),
                        Text("${tour.take["duration"]} days",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.grey),
                            textAlign: TextAlign.start)
                      ],
                    ),
                    Text("\$${tour.take["price"]}",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.start)
                  ],
                ),
                padding: EdgeInsets.fromLTRB(12.0, 4.0, 0, 0),
              ),
            )
          ],
        ));
  }
}
