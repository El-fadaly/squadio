import 'package:flutter/material.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/resources/styles/font_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';
import 'package:squadio/views/components/styled_spacers.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.title,
    this.haveIcon = false,
    this.onIconTapped,
    this.color = Colors.black,
  }) : super(key: key);

  final String title;
  final bool haveIcon;
  final Function()? onIconTapped;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: color,
            ),
          ),
          CustomText(
            text: title,
            fontSize: FontSize.s18,
            fontColor: color,
          ),
          haveIcon
              ? GestureDetector(
                  onTap: onIconTapped,
                  child: const Icon(
                    Icons.download_outlined,
                    color: Colors.white,
                  ),
                )
              : HSpace.med,
        ],
      ),
    );
  }
}
