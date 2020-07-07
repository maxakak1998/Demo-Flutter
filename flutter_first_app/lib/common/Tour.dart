class Tour {
  String _location = "", _urlImage = "";
  int _totalPlace = 0;
  num _duration = 0, _price = 0;
  bool isFavored = false;
  set location(String location) => _location = location;
  set urlImage(String urlImage) => _urlImage = urlImage;
  set totalPlace(int totalPlace) => _totalPlace = totalPlace;
  set duration(num duration) => _duration = duration;
  set price(num price) => _price = price;
  Map<String, dynamic> get take {
    return {
      "location": _location,
      "price": _price,
      "duration": _duration,
      "totalPlace": _totalPlace,
      "urlImage": _urlImage
    };
  }
}
