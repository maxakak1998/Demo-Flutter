class DrawerState {
  int _currentIndex;
  int _previousIndex;

  set currentIndex(int currentIndex) {
    this._currentIndex = currentIndex;
  }

  set previousIndex(int previousIndex) {
    this._previousIndex = previousIndex;
  }

  get getCurrentIndex => this._currentIndex;
  get getPreviousIndex => this._previousIndex;
}
