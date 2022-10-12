import 'package:flutter/material.dart';
import 'package:squadio/business_logic/view_models/profile_view_model.dart';
import 'package:squadio/services/service_locator.dart';
import 'package:squadio/views/components/custom_cached_network_image.dart';
import 'package:squadio/views/components/nav_bar.dart';
import 'package:squadio/views/resources/values_manager.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  static const String id = "ProfileScreen";

  var profileModel = serviceLocator<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: NavBar(
                title: profileModel.selectedPersonName,
                haveIcon: true,
                color: Colors.white,
                onIconTapped: () =>
                    profileModel.onDownloadProfileTapped(context),
              ),
            ),
            Expanded(
              child: CustomCachedNetworkImage(
                width: profileModel.profile.getWidth,
                height: profileModel.profile.getHeight,
                imageUrl: profileModel.profile.getImageUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
