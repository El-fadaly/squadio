import 'dart:io';

import 'package:flutter/services.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateViewModel {
  void onExitAppTapped() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void onUpdateAppTapped() {
    try {
      launchUrl(
        Uri.parse(
          Platform.isIOS
              ? AppConstants.appStoreLink
              : AppConstants.playStoreLink,
        ),
      );
    } catch (e) {
      print("exception opening  market  $e");
    }
  }
}
