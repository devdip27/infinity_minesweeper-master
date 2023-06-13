// ignore_for_file: deprecated_member_use
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';

class TopBarBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Size size;
  final Function? onPressed;
  final Function? onTitleTapped;
  final Widget? child;

  @override
  final Size preferredSize;

  TopBarBack(this.title, this.size,
      {Key? key, this.child, this.onPressed, this.onTitleTapped})
      : preferredSize =
            Size.fromHeight(size.height * StyleConstant.kHeighBarRatio),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: preferredSize.height,
      child: buildTopBar(preferredSize, title, context),
    );
  }
}

Column buildTopBar(Size size, String title, BuildContext context) {
  return Column(
    children: <Widget>[
      Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ClayContainer(
              depth: 20,
              spread: 2,
              color: StyleConstant.mainColor,
              parentColor: StyleConstant.mainColor,
              surfaceColor: StyleConstant.mainColor,
              height: size.height,
              curveType: CurveType.concave,
              customBorderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(StyleConstant.radiusComponent),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/arrow-back.svg",
                    height: StyleConstant.kSizeIcons,
                    width: StyleConstant.kSizeIcons,
                    color: StyleConstant.textColor,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  // width: 290,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 30,
                      color: StyleConstant.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
