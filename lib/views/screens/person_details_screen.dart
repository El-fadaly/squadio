import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squadio/business_logic/view_models/home_view_model.dart';
import 'package:squadio/config/size_config.dart';
import 'package:squadio/services/service_locator.dart';
import 'package:squadio/views/components/custom_fab.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/components/nav_bar.dart';
import 'package:squadio/views/components/person_details_screen/built_dot_widget.dart';
import 'package:squadio/views/components/person_details_screen/profile_slider.dart';
import 'package:squadio/views/components/person_details_screen/known_for_widget.dart';
import 'package:squadio/views/components/person_details_screen/popularity_rate_widget.dart';
import 'package:squadio/views/resources/assets_manager.dart';
import 'package:squadio/views/resources/color_manager.dart';
import 'package:squadio/views/resources/constants_manager.dart';
import 'package:squadio/views/resources/font_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';

class PersonDetailsScreen extends StatelessWidget {
  PersonDetailsScreen({Key? key}) : super(key: key);

  static const String id = 'PersonDetailsScreen';

  var homeModel = serviceLocator<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Consumer<HomeViewModel>(
          builder: (_, model, child) => CustomFab(
            isGrid: model.isGrid,
            onTapped: () => model.changeProfilesLayoutShape(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavBar(title: homeModel.selectedPerson.name ?? ""),
            Consumer<HomeViewModel>(
              builder: (_, model, child) => model.isGrid
                  ?

                  /// image  grid

                  SizedBox(
                      height: SizeConfig.actualHeight / 3,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: AppConstants.gridCrossAxisCount,
                        ),
                        itemBuilder: (_, index) {
                          return ProfileImage(
                            profileImage: model.getImageUrl(
                              model.profiles[index].filePath ?? "",
                            ),
                            onTap: () => model.onProfileTapped(context, index),
                          );
                        },
                        itemCount: model.profiles.length,
                      ),
                    )

                  /// images  slider

                  : Column(
                      children: [
                        // slider
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            onPageChanged: (index, reason) =>
                                model.onImageCarouselPageChanged(index),
                            height: SizeConfig.actualHeight / 3,
                            autoPlay: AppConstants.carouselAutPlay,
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: AppConstants
                                  .imageCarouselAutoPlayAnimationDuration,
                            ),
                            viewportFraction: AppConstants
                                .imageCarouselSliderViewPortFraction,
                            enlargeCenterPage: true,
                          ),
                          itemCount: model.profiles.length,
                          itemBuilder: (context, itemIndex, realIndex) {
                            return ProfileImage(
                              profileImage: model.getImageUrl(
                                model.profiles[itemIndex].filePath ?? "",
                              ),
                              onTap: () =>
                                  model.onProfileTapped(context, itemIndex),
                            );
                          },
                        ),

                        Consumer<HomeViewModel>(
                          builder: (_, model, child) => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                model.profiles.length,
                                (index) => BuiltDots(
                                  isSelected: model.imageIndexBanner == index,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

            const SizedBox(
              height: AppSize.s20,
            ),

            // gender  and  popularity
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///  gender
                  PopularityRateWidget(
                    text: homeModel.getGender(
                      genderCode: homeModel.selectedPerson.gender ?? -1,
                    ),
                  ),

                  /// popularity
                  PopularityRateWidget(
                    text: "${homeModel.selectedPerson.popularity}",
                  ),

                  /// known for
                  PopularityRateWidget(
                    text: "${homeModel.selectedPerson.knownForDepartment}",
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: AppSize.s20,
            ),

            /// known for
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: CustomText(
                text: "Known For",
                fontSize: FontSize.s18,
                fontColor: ColorManager.black,
              ),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),

            Expanded(
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  onPageChanged: (index, reason) =>
                      homeModel.onKnownForCarouselPageChanged(index),
                  height: double.infinity,
                  autoPlay: AppConstants.carouselAutPlay,
                  autoPlayAnimationDuration: const Duration(
                    milliseconds:
                        AppConstants.knownForCarouselAutoPlayAnimationDuration,
                  ),
                  viewportFraction:
                      AppConstants.knownForCarouselSliderViewPortFraction,
                  enlargeCenterPage: true,
                ),
                itemCount: homeModel.selectedPerson.knownFor?.length,
                itemBuilder: (context, itemIndex, realIndex) {
                  final item = homeModel.selectedPerson.knownFor?[itemIndex];
                  return KnownForWidget(
                    image: homeModel.getImageUrl(item?.posterPath ?? ""),
                    name: item?.originalTitle ?? item?.originalName ?? " ",
                    rate: (item?.voteAverage ?? 0.0) / 2,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
