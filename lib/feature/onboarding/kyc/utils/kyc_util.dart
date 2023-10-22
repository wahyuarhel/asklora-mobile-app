import 'package:collection/collection.dart';
import 'package:country_picker/country_picker.dart';

Country? getCountryByIso3(String iso3) {
  List<Country> countries = CountryService().getAll();
  return countries
      .firstWhereOrNull((element) => element.countryCodeIso3 == iso3);
}
