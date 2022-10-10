import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:squadio/views/components/custom_error_icon.dart';
import 'package:squadio/views/components/progress_indicator.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? double.infinity,
      height: height,
      fit: BoxFit.fill,
      imageUrl: imageUrl,
      alignment: Alignment.center,
      errorWidget: (context, url, error) => const CustomErrorIcon(),
      placeholder: (context, url) => const CustomProgressIndicator(),
    );
  }
}
