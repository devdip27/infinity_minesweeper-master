// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinity_sweeper/api/purchase_api.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/providers/purchase_provider.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/button/option_button_widget.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/topbar_back_widget.dart';
import 'package:infinity_sweeper/ui/widgets/paywall_widget.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);
  @override
  PurchasePageState createState() => PurchasePageState();
}

class PurchasePageState extends State<PurchasePage> {
  bool isReady = false;
  bool isFound = false;
  List<Package> packages = [];

  @override
  void initState() {
    super.initState();
    fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBarBack(
        AppLocalizations.of(context)!.purchasePageTitle,
        size,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Consumer<PurchaseProvider>(
                  builder: (context, purchaseProvider, child) {
                    if (!purchaseProvider.isProVersionAds) {
                      if (isReady) {
                        return buildShowOfferings();
                      } else {
                        return showLoadOfferings();
                      }
                    } else if (purchaseProvider.isProVersionAds) {
                      return buildAlreadyPurchase();
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showLoadOfferings() {
    return Column(
      children: <Widget>[
        buildCrown(),
        const SizedBox(height: 50),
        ClayContainer(
          spread: 3,
          curveType: CurveType.concave,
          surfaceColor: StyleConstant.mainColor,
          parentColor: StyleConstant.mainColor,
          customBorderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              AppLocalizations.of(context)!.loadingOffers,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildShowOfferings() {
    return Column(
      children: [
        buildCrown(),
        const SizedBox(height: 50),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: packages.length,
          itemBuilder: (context, index) {
            final package = packages[index];
            return PayWallWidget(
              package,
              context,
              index,
              (Package package) async {
                final String message =
                    await PurchaseApi.purchasePackage(package)
                        ? AppLocalizations.of(context)!.goodPurchase
                        : AppLocalizations.of(context)!.badPurchase;
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(showSnackBar(message, 3));
                }
              },
            );
          },
        ),
        const SizedBox(height: 20),
        OptionButton(
            AppLocalizations.of(context)!.restore, () => restorePurchase()),
      ],
    );
  }

  Widget buildCrown() {
    return ClayContainer(
      spread: 3,
      curveType: CurveType.concave,
      surfaceColor: StyleConstant.mainColor,
      parentColor: StyleConstant.mainColor,
      borderRadius: 100,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  "assets/crown-2.svg",
                  color: StyleConstant.listColors[0],
                  height: 200,
                ),
                SvgPicture.asset(
                  "assets/crown-2.svg",
                  color: StyleConstant.listColors[1],
                  height: 210,
                ),
                SvgPicture.asset(
                  "assets/crown-2.svg",
                  color: StyleConstant.listColors[2],
                  height: 220,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAlreadyPurchase() {
    return Column(
      children: <Widget>[
        buildCrown(),
        const SizedBox(height: 50),
        ClayContainer(
          spread: 3,
          curveType: CurveType.concave,
          surfaceColor: StyleConstant.mainColor,
          parentColor: StyleConstant.mainColor,
          customBorderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              AppLocalizations.of(context)!.alreadyProGamer,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future restorePurchase() async {
    await Provider.of<PurchaseProvider>(context, listen: false)
        .restorePurchase();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar(AppLocalizations.of(context)!.restorePurchaseDone, 4));
    }
  }

  Future fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();
    if (offerings.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            showSnackBar(AppLocalizations.of(context)!.badPurchase, 4));
      }
      setState(() {
        isReady = true;
      });
    } else {
      packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
      setState(() {
        isReady = true;
      });
    }
  }

  SnackBar showSnackBar(String text, int timeInSecond) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: ClayContainer(
        spread: 3,
        curveType: CurveType.concave,
        surfaceColor: StyleConstant.mainColor,
        parentColor: StyleConstant.mainColor,
        customBorderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: StyleConstant.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      duration: Duration(seconds: timeInSecond),
    );
  }
}
