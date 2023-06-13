// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:infinity_sweeper/models/cell/cell_model.dart';
import 'package:infinity_sweeper/providers/game_provider.dart';
import 'package:provider/provider.dart';

class CellWidget extends StatefulWidget {
  final double cellWidth;
  final double cellHeight;
  final CellModel cell;

  const CellWidget(this.cell, this.cellWidth, this.cellHeight, {Key? key})
      : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  late Timer _timer;
  bool isLongPressed = false;

  Widget getContent() {
    if (widget.cell.isShowed) {
      if (widget.cell.isMine) {
        return SvgPicture.asset(
          "assets/bomb.svg",
          color: widget.cell.isLosedCell ? Colors.red : null,
        );
      }
      if (widget.cell.value == 0) return Container();
      return FittedBox(
        child: Text(
          widget.cell.value.toString(),
          style: TextStyle(
            color: StyleConstant.colorNumber[widget.cell.value],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    if (widget.cell.isFlagged) {
      return SvgPicture.asset(
        "assets/flag.svg",
      );
    }
    return Container();
  }

  void setFlag(ctx) {
    Provider.of<GameModelProvider>(ctx, listen: false).setFlag(widget.cell);
    HapticFeedback.mediumImpact();
  }

  void _startOperation(BuildContext ctx) {
    _timer = Timer(const Duration(milliseconds: 150), () {
      isLongPressed = true;
      if (!widget.cell.isShowed) {
        setFlag(ctx);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _startOperation(context);
      },
      onTapUp: (_) {
        //CHECK IF IS FLAG MODALITY
        if (Provider.of<GameModelProvider>(context, listen: false)
            .isFlagsModality()) {
          setFlag(context);
        } else if (!isLongPressed) {
          if (widget.cell.isShowed) {
            Provider.of<GameModelProvider>(context, listen: false)
                .speedOpenCell(widget.cell);
          } else {
            Provider.of<GameModelProvider>(context, listen: false)
                .computeCell(widget.cell);
          }
        }
        isLongPressed = false;
        _timer.cancel();
      },
      child: Container(
        width: widget.cellWidth,
        height: widget.cellHeight,
        decoration: BoxDecoration(
          color: widget.cell.isShowed
              ? Colors.grey.shade300
              : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: getContent(),
          ),
        ),
      ),
    );
  }
}
