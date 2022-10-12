import 'package:flutter/material.dart';
import 'package:squadio/views/resources/styles/color_manager.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    Key? key,
    required this.isGrid,
    required this.onTapped,
  }) : super(key: key);

  final Function() onTapped;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return isGrid
        ? FloatingActionButton(
            backgroundColor: ColorManager.primary,
            onPressed: onTapped,
            child: const Icon(Icons.compare_arrows_sharp),
          )
        : FloatingActionButton(
            backgroundColor: ColorManager.primary,
            onPressed: onTapped,
            child: const Icon(Icons.grid_3x3),
          );
  }
}
