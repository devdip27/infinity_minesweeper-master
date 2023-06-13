import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/data_constant.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/models/game/gamedata_model.dart';
import 'package:infinity_sweeper/providers/gamedata_provider.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/graph/stats_pie_chart.dart';
import 'package:infinity_sweeper/ui/widgets/page_components/topbar_back_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  StatsPageState createState() => StatsPageState();
}

class StatsPageState extends State<StatsPage> {
  GameData gameData = GameData();
  @override
  void initState() {
    super.initState();
    gameData =
        Provider.of<GameDataProvider>(context, listen: false).getGameData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBarBack(AppLocalizations.of(context)!.statistics, size),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClayContainer(
                spread: 3,
                borderRadius: 5,
                curveType: CurveType.none,
                surfaceColor: StyleConstant.mainColor,
                parentColor: StyleConstant.mainColor,
                color: StyleConstant.mainColor,
                child: PieChartStats(gameData),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ClayContainer(
                    spread: 3,
                    width: double.infinity,
                    borderRadius: 5,
                    curveType: CurveType.none,
                    surfaceColor: StyleConstant.mainColor,
                    parentColor: StyleConstant.mainColor,
                    color: StyleConstant.mainColor,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: getRecordElement(
                          AppLocalizations.of(context)!.easy.toLowerCase(),
                          gameData.recordTimeInSecond[DataConstant.recordEasy],
                          StyleConstant.listColors[0]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClayContainer(
                    spread: 3,
                    borderRadius: 5,
                    width: double.infinity,
                    curveType: CurveType.none,
                    surfaceColor: StyleConstant.mainColor,
                    parentColor: StyleConstant.mainColor,
                    color: StyleConstant.mainColor,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: getRecordElement(
                          AppLocalizations.of(context)!.medium.toLowerCase(),
                          gameData
                              .recordTimeInSecond[DataConstant.recordMedium],
                          StyleConstant.listColors[1]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClayContainer(
                    spread: 3,
                    borderRadius: 5,
                    width: double.infinity,
                    curveType: CurveType.none,
                    surfaceColor: StyleConstant.mainColor,
                    parentColor: StyleConstant.mainColor,
                    color: StyleConstant.mainColor,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: getRecordElement(
                          AppLocalizations.of(context)!.hard.toLowerCase(),
                          gameData.recordTimeInSecond[DataConstant.recordHard],
                          StyleConstant.listColors[2]),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding getRecordElement(String difficulty, int? second, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.yourRecord(difficulty),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: StyleConstant.textColor,
            ),
          ),
          Text(
            formatHHMMSS(second!),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String formatHHMMSS(int seconds) {
    if (seconds != 0) {
      int hours = (seconds / 3600).truncate();
      seconds = (seconds % 3600).truncate();
      int minutes = (seconds / 60).truncate();

      String hoursStr = (hours).toString().padLeft(2, '0');
      String minutesStr = (minutes).toString().padLeft(2, '0');
      String secondsStr = (seconds % 60).toString().padLeft(2, '0');

      if (hours == 0) {
        return "$minutesStr:$secondsStr";
      }
      return "$hoursStr:$minutesStr:$secondsStr";
    } else {
      return "";
    }
  }
}
