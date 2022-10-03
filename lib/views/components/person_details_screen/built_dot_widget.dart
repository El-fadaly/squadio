import 'package:flutter/material.dart';
import 'package:squadio/views/resources/color_manager.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class BuiltDots extends StatelessWidget {
  const BuiltDots({
    Key? key,
    required this.isSelected,
  }) : super(key: key);

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(AppPadding.p5),
      margin: const EdgeInsets.all(AppPadding.p5),
      height: AppSize.s8,
      width: isSelected ? AppSize.s20 : AppSize.s8,
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.headerTextColor : Colors.grey[500],
        borderRadius: BorderRadius.circular(AppBorderRadius.r3),
      ),
      duration: const Duration(milliseconds: AppConstants.sliderAnimationTime),
    );
  }
}
