import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_services/games_services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:infinity_sweeper/constants/data_constant.dart';
import 'package:infinity_sweeper/constants/route_constant.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/helpers/ads/ad_banner_helper.dart';
import 'package:infinity_sweeper/helpers/sharedpref_helper.dart';
import 'package:infinity_sweeper/models/game/gamedifficulty_model.dart';
import 'package:infinity_sweeper/providers/purchase_provider.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/button/option_button_widget.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/button/simple_icon_button_widget.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/topbar_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:infinity_sweeper/ui/widgets/page_components/select_game_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdBannerHelper adBannerHelper = AdBannerHelper();
  bool loadedBanner = false;
  int selectedIndex = 1;

  void finishLoad(bool value) {
    setState(() {
      loadedBanner = value;
    });
  }

  void appReview() async {
    SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
    if (await sharedPrefHelper.exist(DataConstant.counterForRequestReview)) {
      int gamePlayed =
          await sharedPrefHelper.read(DataConstant.counterForRequestReview);
      if (gamePlayed >= 7) {
        final InAppReview inAppReview = InAppReview.instance;
        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
          sharedPrefHelper.save(DataConstant.counterForRequestReview, 0);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //create bottom banner
    AppTrackingTransparency.requestTrackingAuthorization();
    adBannerHelper.createBannerAd(finishLoad);
    appReview();
  }

  @override
  void dispose() {
    super.dispose();
    adBannerHelper.adDispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar(size, "Infinity Sweeper"),
      backgroundColor: StyleConstant.mainColor,
      bottomNavigationBar: Consumer<PurchaseProvider>(
        builder: (context, purchaseProvider, child) {
          if (purchaseProvider.isProVersionAds) {
            return Container(height: 1);
          }
          if (loadedBanner) {
            return SizedBox(
              height: adBannerHelper.getSizeBanner().height.toDouble(),
              width: adBannerHelper.getSizeBanner().width.toDouble(),
              child: AdWidget(
                ad: adBannerHelper.getBanner(),
              ),
            );
          } else {
            return Container(
              height: 50,
            );
          }
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.25, child: buildSelectGame()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: OptionButton(
                        AppLocalizations.of(context)!.leaderboard,
                        () => GamesServices.showLeaderboards(
                            iOSLeaderboardID: 'easy_mode_leaderboard'),
                        icon: MdiIcons.trophyAward,
                        colorIcon: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: OptionButton(
                        AppLocalizations.of(context)!.statistics,
                        () => Navigator.of(context)
                            .pushNamed(RouteConstant.statsRoute),
                        icon: FontAwesomeIcons.chartSimple,
                        colorIcon: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: OptionButton(
                        AppLocalizations.of(context)!.purchase,
                        () => Navigator.of(context)
                            .pushNamed(RouteConstant.purchaseRoute),
                        icon: IcoFontIcons.crownKing,
                        svgIcon: SvgPicture.asset(
                          "assets/no_ads.svg",
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                              Colors.red, BlendMode.srcIn),
                        ),
                        colorIcon: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SimpleIconButton(
                        fun: () => Navigator.of(context)
                            .pushNamed(RouteConstant.informationRoute),
                        icon: Icons.info,
                        colorIcon: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SimpleIconButton(
                        fun: () => Navigator.of(context)
                            .pushNamed(RouteConstant.settingsRoute),
                        icon: Icons.settings,
                        colorIcon: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectGame() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: CarouselSlider(
            options: CarouselOptions(
              height: constraints.maxHeight,
              enableInfiniteScroll: false,
              initialPage: 0,
            ),
            items: Difficulty.values.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SelectGame(
                      width: constraints.maxWidth * 0.75,
                      difficulty: i,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
