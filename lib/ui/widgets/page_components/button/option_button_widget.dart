import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';

class OptionButton extends StatelessWidget {
  final String _text;
  final Function _fun;
  final double preferedWidth;
  final IconData? icon;
  final Color? colorIcon;
  final SvgPicture? svgIcon;

  const OptionButton(
    this._text,
    this._fun, {
    this.icon,
    this.colorIcon,
    this.svgIcon,
    this.preferedWidth = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _fun(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = preferedWidth == 0
              ? constraints.maxWidth * StyleConstant.kSizeButton
              : preferedWidth;
          if (icon != null) {
            return ClayContainer(
              borderRadius: 30,
              spread: 2,
              width: width,
              curveType: CurveType.concave,
              surfaceColor: StyleConstant.mainColor,
              parentColor: StyleConstant.mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClayContainer(
                    spread: 3,
                    borderRadius: 30,
                    curveType: CurveType.convex,
                    surfaceColor: StyleConstant.mainColor,
                    parentColor: StyleConstant.mainColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: svgIcon ??
                          Icon(
                            icon,
                            size: 30,
                            color: colorIcon,
                          ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      _text,
                      maxLines: 1,
                      style: const TextStyle(
                        color: StyleConstant.textColor,
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ClayContainer(
              spread: 3,
              borderRadius: 30,
              width: width,
              curveType: CurveType.concave,
              surfaceColor: StyleConstant.mainColor,
              parentColor: StyleConstant.mainColor,
              child: Text(
                _text,
                maxLines: 1,
                style: const TextStyle(
                  color: StyleConstant.textColor,
                  fontSize: 24.0,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
