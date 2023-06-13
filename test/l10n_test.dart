import 'package:country_flags/country_flags.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_sweeper/l10n/l10n.dart';
import 'package:infinity_sweeper/l10n/language_locale_helper.dart';
import 'package:infinity_sweeper/ui/pages/settings_page.dart';

void main() {
  test("Test helper languages - all supported languages", () {
    for (var lang in L10n.allLanguagesSupported) {
      LanguageLocalHelper().getDisplayLanguage(lang.languageCode);
    }
  });

  test("Test helper languages - exist native and name languages", () {
    LanguageLocalHelper().getIsoLangs().forEach((key, value) {
      expect(value["nativeName"], isNotNull);
      expect(value["nativeName"], isNotEmpty);
      expect(value["name"], isNotNull);
      expect(value["name"], isNotEmpty);
    });
  });

  test("CountryFlags widget", () {
    List<CountryFlags> listFlags;
    SettingsPage settingsPage = const SettingsPage();
    final element = settingsPage.createElement(); // this will set state.widget
    final state = element.state as SettingsPageState;

    listFlags = state.getListFlag();

    expect(listFlags.length, L10n.allLanguagesSupported.length);

    for (var flag in listFlags) {
      expect(flag.countryCode, isNotNull);
      expect(flag.countryCode, isNotEmpty);
    }
  });
}
