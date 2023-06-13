import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/route_constant.dart';
import 'package:infinity_sweeper/ui/pages/information_page.dart';
import 'package:infinity_sweeper/ui/pages/minesweeper_page.dart';
import 'package:infinity_sweeper/ui/pages/home_page.dart';
import 'package:infinity_sweeper/ui/pages/purchase_page.dart';
import 'package:infinity_sweeper/ui/pages/settings_page.dart';
import 'package:infinity_sweeper/ui/pages/splashscreen_aurora_page.dart';
import 'package:infinity_sweeper/ui/pages/newgame_page.dart';
import 'package:infinity_sweeper/ui/pages/stats_page.dart';
import 'package:infinity_sweeper/ui/pages/splashscreen_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstant.auroraSplashRoute:
      return MaterialPageRoute(
          builder: (context) => const AuroraSplashScreen());
    case RouteConstant.splashRoute:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case RouteConstant.homeRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case RouteConstant.minesweeperRoute:
      return MaterialPageRoute(builder: (context) => const MinesweeperPage());
    case RouteConstant.statsRoute:
      return MaterialPageRoute(builder: (context) => const StatsPage());
    case RouteConstant.purchaseRoute:
      return MaterialPageRoute(builder: (context) => const PurchasePage());
    case RouteConstant.startGamesRoute:
      return MaterialPageRoute(builder: (context) => const NewGamePage());
    case RouteConstant.informationRoute:
      return MaterialPageRoute(builder: (context) => const InformationPage());
    case RouteConstant.settingsRoute:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
  }
  return MaterialPageRoute(
      builder: (context) => UndefinitedScreen(name: settings.name));
}

class UndefinitedScreen extends StatelessWidget {
  final String? name;
  const UndefinitedScreen({Key? key, this.name = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Undefinited View")),
      body: Center(
        child: Text("Route for $name is not defined"),
      ),
    );
  }
}
