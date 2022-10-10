import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:squadio/views/components/custom_cached_network_image.dart';
import 'package:squadio/views/components/custom_error_icon.dart';
import 'package:squadio/views/components/progress_indicator.dart';
import 'package:squadio/views/resources/assets_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class ProfileImage extends StatelessWidget {
  final String profileImage;
  final int currentPage = 1;
  final Function() onTap;

  const ProfileImage({
    Key? key,
    required this.profileImage,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p2,
          right: AppPadding.p2,
          bottom: AppPadding.p2,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppBorderRadius.r10,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              AppBorderRadius.r10,
            ),
            child: CustomCachedNetworkImage(
              imageUrl: profileImage,
            ),
          ),
        ),
      ),
    );
  }
}
