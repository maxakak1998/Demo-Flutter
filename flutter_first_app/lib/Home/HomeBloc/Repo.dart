import 'dart:async';
import 'dart:developer';
import 'dart:math' as Math;
import 'package:first_app/common/Country.dart';
import 'package:first_app/common/Tour.dart';
import 'package:http/http.dart' as http;
import "dart:convert" as convert;

abstract class HomeRepo {
  Future<List<Tour>> fetchTourData;
  Future<List<Country>> fetchCountryData;
}

class Repo extends HomeRepo {
  String _url = "https://jsonplaceholder.typicode.com/users";

  Repo({String url}) {
    _url = url ?? _url;
  }

  @override
  // TODO: implement fetchTourData
  Future<List<Tour>> get fetchTourData async {
    final response = await http.get(this._url);
    if (response.statusCode == 200) {
      final List<dynamic> data = convert.jsonDecode(response.body);
      final List<Tour> tours =
          data.map((item) => mockDataMappingForTours(item)).toList();
      return tours;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  @override
  // TODO: implement fetchCountryData
  Future<List<Country>> get fetchCountryData async {
    final response = await http.get(this._url);

    if (response.statusCode == 200) {
      final List<dynamic> data = convert.jsonDecode(response.body);

      final List<Country> countries =
          data.map((item) => mockDataMappingForCountries(item)).toList();
      return countries;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Country mockDataMappingForCountries(dynamic item) {
    return new Country(
        name: "Singapore",
        availableTour: new Math.Random().nextInt(200),
        imageUrl: "https://i.ytimg.com/vi/sTFZslRe5Kg/maxresdefault.jpg");
  }

  Tour mockDataMappingForTours(dynamic item) {
    Tour tour = new Tour();
    tour.duration = (new Math.Random().nextDouble() * 20).round();
    tour.location = "Viet Nam ";
    tour.price = (new Math.Random().nextDouble() * 5000).round();
    tour.totalPlace = new Math.Random().nextInt(200);
    tour.urlImage =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRxbK4J6eoK8SjmqEiqTCr1s45UtPxaSeJXFnqf9ngt6iseZMcw&usqp=CAU";
    return tour;
  }
}
