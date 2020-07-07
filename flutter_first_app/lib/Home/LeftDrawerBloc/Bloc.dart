import 'dart:developer';

import 'package:first_app/Home/LeftDrawerBloc/Events.dart';
import 'package:first_app/Home/LeftDrawerBloc/State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  @override
  // TODO: implement initialState
  DrawerState get initialState => DrawerState();

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    // TODO: implement mapEventToState
    if (event is CategoryChangingEvent) {
      yield DrawerState()
        ..previousIndex = state.getCurrentIndex
        ..currentIndex = event.currentIndex;
    }
  }

  void onCategoryChange(int newIndex) {
    log("New index is ${newIndex}");
    add(CategoryChangingEvent(newIndex));
  }
}
