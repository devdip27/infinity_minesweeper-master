import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sweeper/constants/style_constant.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PayWallWidget extends StatefulWidget {
  final BuildContext context;
  final Package package;
  final int index;
  final ValueChanged<Package> onClickedPages;
  const PayWallWidget(
      this.package, this.context, this.index, this.onClickedPages,
      {Key? key})
      : super(key: key);
  @override
  PayWallWidgetState createState() => PayWallWidgetState();
}

class PayWallWidgetState extends State<PayWallWidget> {
  @override
  Widget build(BuildContext context) {
    final product = widget.package.storeProduct;
    return ClayContainer(
      spread: 3,
      curveType: CurveType.concave,
      surfaceColor: StyleConstant.mainColor,
      parentColor: StyleConstant.mainColor,
      customBorderRadius: BorderRadius.circular(12),
      child: Theme(
        data: ThemeData.light(),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: Text(
            product.title,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            product.description,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: StyleConstant.textColor,
            ),
          ),
          trailing: Text(
            product.priceString,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => widget.onClickedPages(widget.package),
        ),
      ),
    );
  }
}
