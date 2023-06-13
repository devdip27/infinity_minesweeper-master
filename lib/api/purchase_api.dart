import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:infinity_sweeper/constants/purchase_constant.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future init() async {
    if (kDebugMode) await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(
        PurchasesConfiguration(PurchaseConstant.getApiKey));
  }

  static Future<List<Offering>> fetchOffersByIds(List<String> ids) async {
    try {
      final offers = await fetchOffers();
      return offers.where((offer) => ids.contains(offer.identifier)).toList();
    } on PlatformException catch (_) {
      return [];
    }
  }

  static Future<List<Offering>> fetchOffers({bool all = true}) async {
    try {
      final offerings = await Purchases.getOfferings();
      if (!all) {
        final current = offerings.current;
        return current == null ? [] : [current];
      } else {
        return offerings.all.values.toList();
      }
    } on PlatformException catch (_) {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
      if (purchaserInfo
          .entitlements.all[PurchaseConstant.idProVersionEnt]!.isActive) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        //showError(e);
      }
      return false;
    }
  }
}
