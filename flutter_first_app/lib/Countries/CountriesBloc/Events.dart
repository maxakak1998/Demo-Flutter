import 'package:first_app/Countries/CountriesBloc/Repo.dart';
import 'package:first_app/common/Country.dart';

abstract class CountryEvent {}

class GetCountiesEvent extends CountryEvent {
  String regionType;
  GetCountiesEvent(this.regionType);
}

class GetDetailCountryEvent extends CountryEvent {
  Country country;
  GetDetailCountryEvent(this.country);
}
