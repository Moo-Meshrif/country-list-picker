import '../model/countries.dart';
import '../model/country.dart';
import '../model/languages.dart';
import 'countires_multi_languages_list.dart';

class CountryPickerHelper {
  static Countries getCountriesFromDialCode(String dialCode) {
    Map<String, dynamic> country = countriesMultiLanguagesList
        .firstWhere((element) => element['dialing_code'] == dialCode);
    return Countries.values.firstWhere(
      (element) => element.iso_3166_1_alpha2 == country['iso_3166_1_alpha2'],
      orElse: () => Countries.Egypt,
    );
  }

  static Country getCountryFromDialCode(Languages language, String dialCode) {
    Map<String, dynamic> country = countriesMultiLanguagesList
        .firstWhere((element) => element['dialing_code'] == dialCode);
    return Country(
      iso_3166_1_alpha2: country['iso_3166_1_alpha2'],
      iso_3166_1_alpha3: country['iso_3166_1_alpha3'],
      name: (country[language.iso_639_2_alpha3].runtimeType == String)
          ? Name(
              common: country[language.iso_639_2_alpha3],
              official: country[language.iso_639_2_alpha3])
          : Name(
              common: country[language.iso_639_2_alpha3]['common'],
              official: country[language.iso_639_2_alpha3]['official']),
      dialing_code: country['dialing_code'],
      default_number_length: country['default_number_length'],
      default_number_format: country['default_number_format'],
      local_number_sample: country['local_number_sample'],
      flagUri: 'assets/flags/${country['iso_3166_1_alpha2'].toLowerCase()}.png',
    );
  }
}
