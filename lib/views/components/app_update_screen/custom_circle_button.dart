import 'package:flutter/material.dart';
import 'package:squadio/config/size_config.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/resources/values_manager.dart';

class CustomCircleButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color color;
  final double? circleRadius;
  final Function() onTap;

  const CustomCircleButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.color,
    this.circleRadius,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(
            SizeConfig.getProportionateScreenWidth(AppPadding.p5)),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(circleRadius ?? AppBorderRadius.r25),
          color: color,
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
