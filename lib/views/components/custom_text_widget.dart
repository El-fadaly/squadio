import 'package:flutter/material.dart';
import 'package:squadio/views/resources/values_manager.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final int? maxLines;
  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = AppSize.s16,
    this.fontWeight = FontWeight.bold,
    this.maxLines,
    this.fontColor = Colors.grey,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.0,
      maxLines: maxLines ?? 2,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Cairo',
      ),
    );
  }
}
