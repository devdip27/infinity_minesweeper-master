import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/helpers/game_logic/difficulty_helper.dart';
import 'package:infinity_sweeper/models/game/gamedifficulty_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectGame extends StatelessWidget {
  final double width;
  final Difficulty difficulty;
  final bool backColoredShadow;
  const SelectGame(
      {required this.width,
      required this.difficulty,
      this.backColoredShadow = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openDifficultyGame(context, difficulty),
      child: ClayContainer(
        borderRadius: 30,
        depth: 20,
        spread: 5,
        width: width,
        curveType: CurveType.concave,
        surfaceColor: StyleConstant.mainColor,
        parentColor: backColoredShadow
            ? StyleConstant.listColorShadeDifficulty[difficulty.index]
            : null,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Flexible(
                child: Image.asset(
                  getDifficultyPathIcon(difficulty),
                  opacity: const AlwaysStoppedAnimation(0.7),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getDifficultyGridSizeString(difficulty),
                        style: TextStyle(
                          fontFamily: 'Futura Round',
                          fontWeight: FontWeight.bold,
                          color: StyleConstant.listColors[difficulty.index],
                          fontSize: 50,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        "${getDifficultyBombString(difficulty)} ${AppLocalizations.of(context)!.bombs.toUpperCase()}",
                        style: const TextStyle(
                          fontSize: 25,
                          color: StyleConstant.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        getDifficultyString(difficulty, context),
                        style: TextStyle(
                          fontFamily: 'Futura Round',
                          color: StyleConstant.listColors[difficulty.index],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
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
}
