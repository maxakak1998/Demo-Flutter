import 'dart:developer';

import 'package:first_app/Countries/CountriesBloc/Repo.dart';
import 'package:first_app/common/Country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Events.dart';
import 'State.dart';

class CountryBLoc extends Bloc<CountryEvent, CountriesState> {
  final Repo repo;
  CountryBLoc(this.repo);
  @override
  // TODO: implement initialState
  CountriesState get initialState => LoadingState();

  void onStartFetchingCountries(String regionType) {
    add(GetCountiesEvent(regionType));
  }

  @override
  Stream<CountriesState> mapEventToState(CountryEvent event) async* {
    if (event is GetCountiesEvent) {
      yield LoadingState();
      log(" Countries  ");

      List<Country> countries =
          await repo.onFetchingCountriesByRegion(event.regionType);

      log(" Countries ${countries} ");

      if (countries == null) {
        yield ErrorState("Country list is null");
        return;
      }

      yield LoadedState(countries: countries);
    }
  }
}
