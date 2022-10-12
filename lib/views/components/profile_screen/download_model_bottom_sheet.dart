import 'package:flutter/material.dart';
import 'package:squadio/config/size_config.dart';
import 'package:squadio/views/components/app_update_screen/custom_circle_button.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/components/styled_spacers.dart';
import 'package:squadio/views/resources/styles/color_manager.dart';
import 'package:squadio/views/resources/strings_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class DownloadModelBottomSheet extends StatelessWidget {
  const DownloadModelBottomSheet({
    Key? key,
    required this.onBackgroundDownloadTapped,
    required this.onForegroundDownloadTapped,
  }) : super(key: key);

  final Function() onForegroundDownloadTapped;
  final Function() onBackgroundDownloadTapped;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.actualHeight / 3,
      padding: const EdgeInsets.all(AppPadding.p14),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(text: "Please choose you download method"),
            VSpace.xl,
            CustomCircleButton(
              height: SizeConfig.getProportionateScreenHeight(55),
              width: double.infinity,
              circleRadius: AppBorderRadius.r15,
              text: AppStrings.downloadImageInBackground,
              color: ColorManager.primary,
              onTap: onBackgroundDownloadTapped,
            ),
            VSpace.lg,
            CustomCircleButton(
              height: SizeConfig.getProportionateScreenHeight(55),
              width: double.infinity,
              circleRadius: AppBorderRadius.r15,
              text: AppStrings.downloadImageInForeground,
              color: ColorManager.error,
              onTap: onForegroundDownloadTapped,
            ),
          ],
        ),
      ),
    );
  }
}
