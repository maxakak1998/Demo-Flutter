abstract class AppEvent {}

class SaveFavoriteEvent extends AppEvent {
  int favoriteCount;
  SaveFavoriteEvent(this.favoriteCount);
}
