import 'dart:developer';

import 'package:first_app/common/Country.dart';
import 'package:first_app/common/Tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Events.dart';
import "Repo.dart";
import "State.dart";

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  Repo repo;
  List<Country> counties;
  List<Tour> tours;
  HomeBloc(this.repo);
  @override
  // TODO: implement initialState
  HomeState get initialState => LoadingState();

  @override
  void onEvent(HomeEvents event) {
    // TODO: implement onEvent
    super.onEvent(event);
    log("Event is ${event}");
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    // TODO: implement mapEventToState

    log("Go to mapEventToState");
    if (event is StartFetchingDataEvent) {
      yield LoadingState();

      try {
        if (counties == null) {
          counties = await repo.fetchCountryData;
        }
        if (tours == null) {
          tours = await repo.fetchTourData;
        }

        if (counties == null || tours == null) {
          throw new NullThrownError();
        }
        yield LoadedState(tours: tours, countries: counties);
        
      } catch (e) {
        final String message = "Lists are null ${e.toString()}";
        print(message);
        yield ErrorState(message);
      }
    } else if (event is DataTourChangingEvent) {
      tours[event.indexChangedItem] = event.newTour;

      yield LoadedState(tours: tours, countries: counties);
    }
  }

  void onStartFetching() {
    add(StartFetchingDataEvent());
  }

  void onDataTourChanged(int index, Tour newTour) {
    add(DataTourChangingEvent(index, newTour));
  }
}
