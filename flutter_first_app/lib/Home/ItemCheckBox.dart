import 'package:first_app/AppBloc/Bloc.dart';
import 'package:first_app/Home/HomeBloc/Bloc.dart';
import 'package:first_app/Home/HomeBloc/Repo.dart';
import 'package:first_app/common/Tour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class ItemCheckBox extends StatelessWidget {
  final Tour tour;
  final int index;
  ItemCheckBox({Key key, this.index, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tour.isFavored ? Colors.blue : Colors.grey.withOpacity(0.7)),
        child: InkWell(
          onTap: () {
            onAdd(context);
          },
          child: Center(
              child: tour.isFavored
                  ? Icon(Icons.favorite, size: 18.0, color: Colors.red)
                  : Icon(Icons.favorite, size: 18.0, color: Colors.white)),
        ),
      ),
    );
  }

  void onAdd(BuildContext context) {
    Tour newTour = new Tour();
    newTour.duration = tour.take["duration"];
    newTour.location = tour.take["location"];
    newTour.totalPlace = tour.take["totalPlace"];
    newTour.price = tour.take["price"];
    newTour.urlImage = tour.take["urlImage"];
    newTour.isFavored = !tour.isFavored;
    print("Key is ${index}");
    BlocProvider.of<HomeBloc>(context).onDataTourChanged(index, newTour);
  }
}
