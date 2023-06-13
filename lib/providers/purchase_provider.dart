import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity_sweeper/constants/purchase_constant.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseProvider extends ChangeNotifier {
  bool isProVersionAds = true;

  PurchaseProvider() {
    init();
    getUserPurchases();
    notifyListeners();
  }

  Future<bool> getIsActivePurchases(String idEnt) async {
    try {
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      // access latest purchaserInfo
      if (purchaserInfo.entitlements.all.isEmpty) {
        return false;
      }
      if (purchaserInfo.entitlements.all[idEnt] != null &&
          purchaserInfo.entitlements.all[idEnt]!.isActive) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  void getUserPurchases() async {
    isProVersionAds =
        await getIsActivePurchases(PurchaseConstant.idProVersionEnt);
  }

  Future init() async {
    try {
      Purchases.addCustomerInfoUpdateListener((purchaseInfo) async {
        getUserPurchases();
        notifyListeners();
      });
    } on PlatformException catch (_) {}
  }

  Future<void> restorePurchase() async {
    try {
      await Purchases.restorePurchases();
      getUserPurchases();
      notifyListeners();
    } on PlatformException catch (_) {
      // Error restoring purchases
    }
  }
}
