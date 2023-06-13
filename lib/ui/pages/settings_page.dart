import 'package:clay_containers/clay_containers.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/helpers/sharedpref_helper.dart';
import 'package:infinity_sweeper/l10n/l10n.dart';
import 'package:infinity_sweeper/l10n/language_locale_helper.dart';
import 'package:infinity_sweeper/providers/locale_provider.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/topbar_back_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
  List<CountryFlags> listFlags = [];
  String flagLanguageCode = "";

  void loadPreferences(BuildContext context) async {
    listFlags = getListFlag();

    flagLanguageCode = Provider.of<LocaleProvider>(context, listen: false)
        .locale!
        .languageCode
        .toString();

    CountryFlags el = flagLanguageCode == "en"
        ? listFlags.firstWhere((element) => element.countryCode == "gb")
        : listFlags
            .firstWhere((element) => element.countryCode == flagLanguageCode);

    setState(() {
      listFlags.remove(el);
      listFlags.insert(0, el);
    });
  }

  @override
  void initState() {
    super.initState();
    loadPreferences(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBarBack(AppLocalizations.of(context)!.settings, size),
      backgroundColor: StyleConstant.mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClayContainer(
                spread: 3,
                width: double.infinity,
                borderRadius: 30,
                curveType: CurveType.none,
                surfaceColor: StyleConstant.mainColor,
                parentColor: StyleConstant.mainColor,
                color: StyleConstant.mainColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          AppLocalizations.of(context)!.settings_languageText,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 28,
                            color: StyleConstant.textColor,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                            child: Divider(
                              color: Colors.transparent,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shrinkWrap: true,
                          itemCount: listFlags.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () =>
                                  setLocale(listFlags[index].countryCode),
                              child: ClayContainer(
                                borderRadius: 10,
                                spread: 2,
                                curveType: CurveType.concave,
                                surfaceColor: StyleConstant.mainColor,
                                parentColor: StyleConstant.mainColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      listFlags[index],
                                      Text(
                                        getLanguageNameFromCountryCode(
                                            listFlags[index].countryCode),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight:
                                              getLanguageCodeFromCountryCode(
                                                          listFlags[index]
                                                              .countryCode) ==
                                                      flagLanguageCode
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setLocale(String countryCode) {
    Provider.of<LocaleProvider>(context, listen: false)
        .setLocale(Locale(getLanguageCodeFromCountryCode(countryCode)));
    loadPreferences(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: RepaintBoundary(
                      child: CircularProgressIndicator(
                        color: StyleConstant.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
      },
    );
  }

  String getLanguageNameFromCountryCode(String countryCode) {
    return LanguageLocalHelper()
        .getNativeLanguageName(getLanguageCodeFromCountryCode(countryCode));
  }

  String getLanguageCodeFromCountryCode(String countryCode) {
    return countryCode == "gb" ? "en" : countryCode;
  }

// Unit tested
  List<CountryFlags> getListFlag() {
    List<CountryFlags> listFlag = <CountryFlags>[];
    for (var i = 0; i < L10n.allLanguagesSupported.length; i++) {
      String countryCode = L10n.allLanguagesSupported[i].languageCode;
      if (L10n.allLanguagesSupported[i].languageCode == "en") {
        countryCode = "gb";
      }
      listFlag.add(CountryFlags.flag(
        countryCode,
        height: 40,
        width: 40,
        borderRadius: 10,
      ));
    }
    return listFlag;
  }
}
