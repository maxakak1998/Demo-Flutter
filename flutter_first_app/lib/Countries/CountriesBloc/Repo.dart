import 'dart:math';

import 'package:first_app/DetailCountry/DetailCountry.dart';
import 'package:first_app/common/Country.dart';
import 'package:first_app/Home/HomeBloc/Repo.dart' as HomeRepo;
import 'package:http/http.dart' as http;
import "dart:convert" as convert;

abstract class CountriesRepo {
  Future<List<Country>> onFetchingCountriesByRegion(String regionType);
}

class Repo extends CountriesRepo {
  @override
  Future<List<Country>> onFetchingCountriesByRegion(String regionType) async {
    // List<Country> countries = await new HomeRepo.Repo().fetchCountryData;

    List<Country> countries =
        (await new HomeRepo.Repo().fetchCountryData).map((value) {
      value.setName = regionType;
      return value;
    }).toList();

    return countries ?? null;
  }
}
