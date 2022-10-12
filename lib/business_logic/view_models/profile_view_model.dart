import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:squadio/business_logic/models/pooular_persons/images/profile_model.dart';
import 'package:squadio/services/download_image_service/downlad_image_in_background_service.dart';
import 'package:squadio/services/download_image_service/download_image_in_foreground_service.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/components/profile_screen/download_model_bottom_sheet.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:squadio/views/resources/strings_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class ProfileViewModel {
  late ProfileModel profile;

  late String selectedPersonName;

  void onDownloadProfileTapped(context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppBorderRadius.r20),
        ),
      ),
      builder: (builder) {
        return DownloadModelBottomSheet(
          onBackgroundDownloadTapped: () async => downloadInBackground(context),
          onForegroundDownloadTapped: () async => downloadInForeground(context),
        );
      },
    );
  }

  void downloadInBackground(context) async {
    Navigator.of(context).pop();
    showSnackBar(context, start: true);
    var downloadImageInBackgroundService = DownloadImageInBackgroundService();
    var response = await downloadImageInBackgroundService.downloadImageByUrl(
        url: profile.getImageUrl);
    showResponseForUser(context, response);
  }

  void downloadInForeground(context) async {
    Navigator.of(context).pop();

    EasyLoading.show();

    var downloadImageInForeground = DownloadImageInForeground();
    var response = await downloadImageInForeground.downloadImageByUrl(
        url: profile.getImageUrl);

    EasyLoading.dismiss();

    showResponseForUser(context, response);
  }

  void showResponseForUser(context, success) {
    if (success) {
      showSnackBar(context, success: true);
    } else {
      showSnackBar(context, success: false);
    }
  }

  void showSnackBar(context, {start = false, success}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: start
              ? AppStrings.downloadingImageInBackground
              : success
                  ? AppStrings.downloadedImage
                  : AppStrings.downloadedImageErrorMessage,
        ),
      ),
    );
  }
}
