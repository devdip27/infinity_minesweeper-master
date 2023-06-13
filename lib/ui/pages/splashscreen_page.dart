import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/helpers/games_service/gameservices_helper.dart';
import 'package:infinity_sweeper/ui/pages/home_page.dart';
import 'package:infinity_sweeper/providers/gamedata_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreen> {
  GamesServicesHelper gamesServicesHelper = GamesServicesHelper();
  @override
  void initState() {
    super.initState();
    gamesServicesHelper.loadGamesService();
    Provider.of<GameDataProvider>(context, listen: false).initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/icons/icon_trasparent.png'),
      logoWidth: 100,
      title: const Text(
        "Infinity MineSweeper",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: StyleConstant.mainColor,
      showLoader: false,
      loadingText: Text(AppLocalizations.of(context)!.loading),
      navigator: const HomePage(),
      durationInSeconds: 3,
    );
  }
}
