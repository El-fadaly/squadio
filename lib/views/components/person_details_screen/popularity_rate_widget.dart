import 'package:flutter/material.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/resources/styles/color_manager.dart';
import 'package:squadio/views/resources/styles/font_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class PopularityRateWidget extends StatelessWidget {
  const PopularityRateWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppBorderRadius.r20),
        ),
        side: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p14,
        ),
        child: CustomText(
          text: text,
          fontSize: FontSize.s18,
        ),
      ),
    );
  }
}
