import 'package:flutter/material.dart';
import 'package:squadio/views/resources/strings_manager.dart';
import 'package:squadio/views/screens/home_screen.dart';
import 'package:squadio/views/screens/person_details_screen.dart';
import 'package:squadio/views/screens/profile_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case PersonDetailsScreen.id:
        return MaterialPageRoute(
          builder: (_) => PersonDetailsScreen(),
        );
      case ProfileScreen.id:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
