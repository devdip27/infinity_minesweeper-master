import 'dart:io';

class AppConstant {
  static String get appIdIOS => '1601719229';
  static String get appIdAndroid => 'com.eliatolin.infinity_sweeper';
  static String get appId {
    if (Platform.isAndroid) {
      return appIdAndroid;
    } else if (Platform.isIOS) {
      return appIdIOS;
    } else {
      return "";
    }
  }

  static String get emailAurora => "info@auroradigital.it";
}
