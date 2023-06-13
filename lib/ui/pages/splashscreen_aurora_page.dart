import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/helpers/games_service/gameservices_helper.dart';
import 'package:infinity_sweeper/providers/gamedata_provider.dart';
import 'package:infinity_sweeper/providers/locale_provider.dart';
import 'package:infinity_sweeper/ui/pages/splashscreen_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuroraSplashScreen extends StatefulWidget {
  const AuroraSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<AuroraSplashScreen> {
  GamesServicesHelper gamesServicesHelper = GamesServicesHelper();
  @override
  void initState() {
    super.initState();
    gamesServicesHelper.loadGamesService();
    context.read<LocaleProvider>().initLocale(context);
    Provider.of<GameDataProvider>(context, listen: false).initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/icons/aurora_icon.png'),
      logoWidth: 100,
      backgroundColor: StyleConstant.mainColor,
      showLoader: false,
      loadingText: Text(AppLocalizations.of(context)!.loading),
      navigator: const SplashScreen(),
      durationInSeconds: 2,
    );
  }
}
