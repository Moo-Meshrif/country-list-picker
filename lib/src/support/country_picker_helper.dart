import '../model/countries.dart';
import '../model/country.dart';
import '../model/languages.dart';
import 'countires_multi_languages_list.dart';

class CountryPickerHelper {
  
  /// Get a country from its dial code
  static Countries getCountriesFromDialCode(String dialCode) {
    Map<String, dynamic> country = countriesMultiLanguagesList
        .firstWhere((element) => element['dialing_code'] == dialCode);
    return Countries.values.firstWhere(
      (element) => element.iso_3166_1_alpha2 == country['iso_3166_1_alpha2'],
      orElse: () => Countries.Egypt,
    );
  }

  /// Get a country from its dial code
  static Country? getCountryFromDialCode(Languages language, String dialCode) {
    int index = countriesMultiLanguagesList
        .indexWhere((element) => element['dialing_code'] == dialCode);
    if (index == -1) return null;
    Map<String, dynamic> country = countriesMultiLanguagesList[index];
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

  /// Validate a phone number based on the country's dial code.
  static bool validatePhoneNumber(String phoneNumber, String dialCode) {
    Country? country = getCountryFromDialCode(Languages.English, dialCode);
    if (country == null) return false;
    int length = phoneNumber.length;
    return length == country.default_number_length;
  }
}
