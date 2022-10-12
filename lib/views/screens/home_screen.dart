import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squadio/business_logic/view_models/home_view_model.dart';
import 'package:squadio/services/service_locator.dart';
import 'package:squadio/views/components/custom_text_widget.dart';
import 'package:squadio/views/components/home_screen/person_card.dart';
import 'package:squadio/views/components/nav_bar.dart';
import 'package:squadio/config/size_config.dart';
import 'package:squadio/views/components/progress_indicator.dart';
import 'package:squadio/views/resources/strings_manager.dart';
import 'package:squadio/views/resources/values_manager.dart';
import 'package:squadio/views/screens/app_update_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeViewModel = serviceLocator<HomeViewModel>();
  late Future<bool> needUpdate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    needUpdate = homeViewModel.appNeedToUpDate();
  }

  @override
  void dispose() {
    homeViewModel.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return FutureBuilder(
      future: needUpdate,
      builder: (_, AsyncSnapshot asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.done) {
          if (asyncSnapshot.data) {
            return AppUpdateScreen();
          } else {
            /// load  data  for  home  screen
            homeViewModel.initData();
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const NavBar(title: AppStrings.homeTitle),
                      Expanded(
                        child: Consumer<HomeViewModel>(
                          builder: (context, model, child) => ListView.builder(
                            controller: model.scrollController,
                            scrollDirection: Axis.vertical,

                            /// item count is persons  + 1   because there is one  more  item which is the progress indicator item or no more  data to show
                            itemCount: model.persons.length + 1,
                            itemBuilder: (_, index) {
                              /// persons  items
                              if (index < model.persons.length) {
                                final person = model.persons[index];
                                return PersonCard(
                                  field: person.getKnownForDepartment,
                                  name: person.getName,
                                  imageUrl: person.getImageUrl,
                                  onTapped: () => model.openPersonDetailsScreen(
                                    context,
                                    index,
                                  ),
                                );
                              }

                              /// last  item which is the progress indicator item or no more  data to show
                              else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p28,
                                  ),
                                  child: Center(
                                    child: model.hasMoreData
                                        ? const CustomProgressIndicator()
                                        : const CustomText(
                                            text: AppStrings.noMoreActors,
                                          ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }
}
