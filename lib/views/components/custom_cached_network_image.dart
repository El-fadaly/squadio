import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:squadio/views/components/custom_error_icon.dart';
import 'package:squadio/views/components/progress_indicator.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({Key? key, required this.image, s})
      : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      fit: BoxFit.fill,
      imageUrl: image,
      alignment: Alignment.center,
      errorWidget: (context, url, error) => const CustomErrorIcon(),
      placeholder: (context, url) => const CustomProgressIndicator(),
    );
  }
}
