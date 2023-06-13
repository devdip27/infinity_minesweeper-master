import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/preference_constant.dart';
import 'package:infinity_sweeper/helpers/sharedpref_helper.dart';
import 'package:infinity_sweeper/l10n/l10n.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  void initLocale(context) async {
    SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
    if (await sharedPrefHelper.exist(PreferenceConstant.languagePreferences)) {
      String languageCode =
          await sharedPrefHelper.read(PreferenceConstant.languagePreferences);
      if (languageCode.isNotEmpty) {
        setLocale(Locale(languageCode));
      }
      return;
    }
    _locale = Locale(Localizations.localeOf(context).languageCode);
  }

  void setLocale(Locale loc) {
    SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
    sharedPrefHelper.save(
        PreferenceConstant.languagePreferences, loc.languageCode);
    if (!L10n.allLanguagesSupported.contains(loc)) return;
    _locale = loc;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
