import 'package:first_app/common/Country.dart';

abstract class CountriesState {
  List<Country> _countries;
}

class LoadingState extends CountriesState {}

class LoadedState extends CountriesState {
  LoadedState({List<Country> countries}) {
    this._countries = countries;
  }

  List<Country> get getCountries => super._countries;
}

class ErrorState extends CountriesState {
  String message = "";
  ErrorState(this.message);
}
