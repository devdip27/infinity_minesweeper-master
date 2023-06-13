import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinity_sweeper/constants/route_constant.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/providers/game_provider.dart';
import 'package:infinity_sweeper/providers/time_provider.dart';
import 'package:infinity_sweeper/ui/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoBar extends StatelessWidget {
  final double maxHeight;
  const InfoBar(this.maxHeight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight * StyleConstant.kHeighBarRatio,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(StyleConstant.kPaddingComponent),
        child: ClayContainer(
          spread: 3,
          borderRadius: 5,
          curveType: CurveType.concave,
          surfaceColor: StyleConstant.mainColor,
          parentColor: StyleConstant.mainColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Consumer<GameModelProvider>(
                  builder: (context, gameModel, child) {
                    return IconButton(
                      onPressed: () => gameModel.setFlagsModality(),
                      icon: Icon(
                        Icons.flag,
                        size: 30,
                        color: gameModel.isFlagsModality()
                            ? Colors.black
                            : Colors.red,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<GameModelProvider>(
                  builder: (context, gameModel, child) {
                    return Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          gameModel.numFlag.toString(),
                          style: const TextStyle(
                            fontSize: 30.0,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<GameModelProvider>(
                  builder: (context, gameModel, child) {
                    return Text(
                      " ${AppLocalizations.of(context)!.bombs.toUpperCase()}",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey.shade800,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<TimerProvider>(
                  builder: (context, timeProvider, child) {
                    return Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          timeProvider.getString(),
                          style: const TextStyle(
                            fontSize: 30.0,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<TimerProvider>(
                  builder: (context, timeProvider, child) {
                    return Text(
                      " ${AppLocalizations.of(context)!.time.toUpperCase()}",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey.shade800,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.home),
                  iconSize: 40,
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.black26,
                      context: context,
                      builder: (context) {
                        return CustomDialogBox(
                          AppLocalizations.of(context)!.gamePauseTitle,
                          AppLocalizations.of(context)!.gamePauseDescr,
                          AppLocalizations.of(context)!.home,
                          "assets/icons/home.png",
                          () => Navigator.of(context).pushNamedAndRemoveUntil(
                              RouteConstant.homeRoute, (route) => false),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
