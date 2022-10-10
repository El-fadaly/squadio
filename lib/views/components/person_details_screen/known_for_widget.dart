import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:squadio/views/components/custom_cached_network_image.dart';
import 'package:squadio/views/components/custom_error_icon.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/components/person_details_screen/rating_bar.dart';
import 'package:squadio/views/components/progress_indicator.dart';
import 'package:squadio/views/resources/color_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class KnownForWidget extends StatelessWidget {
  const KnownForWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.rate,
  }) : super(key: key);

  final String image;
  final String name;
  final num rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSize.s8,
      child: Column(
        children: [
          /// image
          Expanded(
            child: CustomCachedNetworkImage(imageUrl: image),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// name
                CustomText(
                  text: name,
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),

                /// rating  bar  and  value
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "$rate",
                      fontColor: ColorManager.headerTextColor,
                    ),
                    StarRating(
                      rating: rate,
                      color: ColorManager.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
