import 'package:flutter/material.dart';
import 'package:squadio/views/components/custom_cached_network_image.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/config/size_config.dart';
import 'package:squadio/views/resources/values_manager.dart';
import 'package:squadio/views/components/styled_spacers.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.field,
    required this.name,
    required this.imageUrl,
    required this.onTapped,
  }) : super(key: key);

  final String name;
  final String field;
  final String imageUrl;
  final Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p2),
      child: GestureDetector(
        onTap: onTapped,
        child: Card(
          elevation: AppSize.s4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppBorderRadius.r15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Row(
              children: [
                /// avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppBorderRadius.r10,
                  ),
                  child: CustomCachedNetworkImage(
                    imageUrl: imageUrl,
                    height: SizeConfig.screenHeight / 12,
                    width: SizeConfig.screenWidth / 5,
                  ),
                ),

                HSpace.med,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// name
                    CustomText(
                      text: name,
                    ),

                    VSpace.med,

                    /// field
                    CustomText(
                      text: field,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
