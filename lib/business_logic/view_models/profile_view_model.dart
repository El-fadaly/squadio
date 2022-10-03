import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:squadio/business_logic/models/pooular_persons/images/profile_model.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:squadio/views/resources/strings_manager.dart';

class ProfileViewModel {
  late ProfileModel profile;

  late String selectedPersonName;

  void onDownloadProfileTapped(context) async {
    try {
      EasyLoading.show();

      var response = await GallerySaver.saveImage(getImageUrl());

      if (response ?? false) {
        showSnackBar(context, success: true);
      } else {
        throw ArgumentError("Not downloaded");
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, success: false);
    }
  }

  void showSnackBar(context, {success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: success
              ? AppStrings.downloadedImage
              : AppStrings.downloadedImageErrorMessage,
        ),
      ),
    );
  }

  String getImageUrl() {
    return '${AppConstants.imageDetailsUrl}${profile.filePath}';
  }
}
