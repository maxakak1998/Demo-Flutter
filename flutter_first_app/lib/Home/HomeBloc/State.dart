import 'package:first_app/common/Country.dart';
import 'package:first_app/common/Tour.dart';

abstract class HomeState {
  List<Tour> tours;
  List<Country> countries;
}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {
  LoadedState({List<Tour> tours, List<Country> countries}) {
    this.tours = tours;
    this.countries = countries;
  }
  @override
  List<Tour> get tours => super.tours;

  @override
  List<Country> get countries => super.countries;

  int get favCount {
    return tours.fold(0, (acc, current) => current.isFavored ? acc + 1 : acc);
  }
}

class ErrorState extends HomeState {
  String message;
  ErrorState(this.message);
}
