abstract class AppState {
  int favouriteCount;
}

class GlobalState extends AppState {
  GlobalState();
  @override
  // TODO: implement favouriteCount
  int get getFavoriteCount => super.favouriteCount;
  @override
  set favouriteCount(int _favouriteCount) {
    // TODO: implement favouriteCount
    super.favouriteCount = _favouriteCount;
  }

  factory GlobalState.init() {
    return GlobalState()..favouriteCount = 0;
  }
}
