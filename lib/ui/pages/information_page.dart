import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:infinity_sweeper/constants/app_constant.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/button/simple_icon_button_widget.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/topbar_back_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBarBack("Info", size),
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
                spread: 2,
                borderRadius: 30,
                curveType: CurveType.none,
                surfaceColor: StyleConstant.mainColor,
                parentColor: StyleConstant.mainColor,
                color: StyleConstant.mainColor,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage("assets/auroradigital_logo.png"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ClayContainer(
                spread: 3,
                borderRadius: 30,
                width: double.infinity,
                curveType: CurveType.none,
                surfaceColor: StyleConstant.mainColor,
                parentColor: StyleConstant.mainColor,
                color: StyleConstant.mainColor,
                child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      AppLocalizations.of(context)!.info_openSourceText,
                      style: const TextStyle(
                        color: StyleConstant.textColor,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              const SizedBox(height: 20),
              ClayContainer(
                spread: 3,
                width: double.infinity,
                borderRadius: 30,
                curveType: CurveType.none,
                surfaceColor: StyleConstant.mainColor,
                parentColor: StyleConstant.mainColor,
                color: StyleConstant.mainColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      buildReview(context),
                      const SizedBox(height: 20),
                      buildWriteUs(context),
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

  Column buildReview(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.review,
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 25.0,
          ),
          textAlign: TextAlign.start,
        ),
        Text(
          AppLocalizations.of(context)!.info_reviewText,
          style: const TextStyle(
            color: StyleConstant.textColor,
            fontSize: 15.0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SimpleIconButton(
          icon: Icons.reviews,
          colorIcon: Colors.amber,
          preferedWidth: 40,
          fun: () => openStoreForReview(),
        ),
      ],
    );
  }

  Column buildWriteUs(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.contactUs,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 25.0,
          ),
          textAlign: TextAlign.start,
        ),
        Text(
          AppLocalizations.of(context)!.info_contactUsText,
          style: const TextStyle(
            color: StyleConstant.textColor,
            fontSize: 15.0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SimpleIconButton(
          icon: Icons.email,
          colorIcon: Colors.blue,
          preferedWidth: 40,
          fun: () => openEmail(),
        ),
      ],
    );
  }

  openStoreForReview() {
    final InAppReview inAppReview = InAppReview.instance;

    inAppReview.openStoreListing(appStoreId: AppConstant.appIdIOS);
  }

  openEmail() async {
    final Email email = Email(
      body: '',
      subject: 'Infinity Minesweeper - Feedback',
      recipients: [AppConstant.emailAurora],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
