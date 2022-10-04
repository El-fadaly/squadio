import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:squadio/business_logic/view_models/app_update_view_model.dart';
import 'package:squadio/config/size_config.dart';
import 'package:squadio/services/service_locator.dart';
import 'package:squadio/views/components/app_update_screen/custom_circle_button.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/resources/color_manager.dart';
import 'package:squadio/views/resources/font_manager.dart';
import 'package:squadio/views/resources/strings_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class AppUpdateScreen extends StatelessWidget {
  AppUpdateScreen({Key? key}) : super(key: key);

  var appUpdateModel = serviceLocator<AppUpdateViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: ColorManager.primary,
                size: AppSize.s60,
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              CustomText(
                text:
                    "Sorry Your App needs an update to work properly please  update  now ",
                fontColor: ColorManager.primary,
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.medium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCircleButton(
                    height: SizeConfig.getProportionateScreenHeight(55),
                    width: SizeConfig.getProportionateScreenWidth(150),
                    circleRadius: AppBorderRadius.r15,
                    text: AppStrings.update,
                    color: ColorManager.primary,
                    onTap: appUpdateModel.onUpdateAppTapped,
                  ),
                  const SizedBox(
                    width: AppSize.s8,
                  ),
                  CustomCircleButton(
                    height: SizeConfig.getProportionateScreenHeight(55),
                    width: SizeConfig.getProportionateScreenWidth(150),
                    circleRadius: AppBorderRadius.r15,
                    text: AppStrings.closeApp,
                    color: ColorManager.error,
                    onTap: appUpdateModel.onExitAppTapped,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
