abstract class DrawerEvent {}

class CategoryChangingEvent extends DrawerEvent {
  int currentIndex;

  CategoryChangingEvent(this.currentIndex);
}
