import 'package:flutter/foundation.dart';

class Country {
  String _name;
  int _availableTour;
  String _imageUrl;
  Country(
      {String name = "Unavailable",
      int availableTour = 0,
      @required String imageUrl}) {
    this._name = name;
    this._availableTour = availableTour;
    this._imageUrl = imageUrl;
  }
  get getGame => _name;
  get getAvailableTour => _availableTour;
  get getImageUrl => _imageUrl;

  set setName(String name) {
    _name = name;
  }

  set setAvailableTour(int availableTour) {
    _availableTour = availableTour;
  }

  set setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }
}
