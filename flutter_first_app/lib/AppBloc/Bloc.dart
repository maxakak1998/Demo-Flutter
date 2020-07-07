import 'dart:developer';

import 'package:first_app/AppBloc/Events.dart';
import 'package:first_app/AppBloc/State.dart';
import 'package:first_app/common/Tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  // TODO: implement initialState
  AppState get initialState => GlobalState.init();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SaveFavoriteEvent) {
      log(" a ${event.favoriteCount}");

      yield GlobalState()..favouriteCount = event.favoriteCount;
    }
  }

  void onFavoriteChange(List<Tour> tours) {
    final int count =
        tours.fold(0, (acc, current) => current.isFavored ? acc + 1 : acc);
    add(SaveFavoriteEvent(count));
  }
}
