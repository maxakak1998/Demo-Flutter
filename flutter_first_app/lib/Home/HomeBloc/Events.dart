import 'package:first_app/common/Tour.dart';
import 'package:http/http.dart' as http;
import "dart:convert" as convert;

abstract class HomeEvents {}

class StartFetchingDataEvent extends HomeEvents {}

class DataTourChangingEvent extends HomeEvents {
  int indexChangedItem;
  Tour newTour;
  DataTourChangingEvent(this.indexChangedItem, this.newTour);
}
