import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';

class SimpleIconButton extends StatelessWidget {
  final IconData icon;
  final Color colorIcon;
  final Function fun;
  final double preferedWidth;

  const SimpleIconButton(
      {required this.icon,
      required this.colorIcon,
      required this.fun,
      this.preferedWidth = 30,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => fun(),
      child: ClayContainer(
        spread: 3,
        borderRadius: 30,
        curveType: CurveType.convex,
        surfaceColor: StyleConstant.mainColor,
        parentColor: StyleConstant.mainColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: preferedWidth,
            color: colorIcon,
          ),
        ),
      ),
    );
  }
}
