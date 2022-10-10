import 'package:flutter/material.dart';
import 'package:squadio/views/resources/values_manager.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final num rating;
  final Color color;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    required this.color,
  });

  Icon getIcon(iconData) => Icon(
        iconData,
        color: color,
        size: AppSize.s20,
      );
  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = getIcon(Icons.star_border);
    } else if (index > rating - 1 && index < rating) {
      icon = getIcon(Icons.star_half);
    } else {
      icon = getIcon(Icons.star);
    }
    return InkResponse(
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
