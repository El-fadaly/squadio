import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:squadio/business_logic/view_models/home_view_model.dart';
import 'package:squadio/services/remote_config_service/remote_config_service.dart';
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
  late final Future<bool> needUpdate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    needUpdate = homeViewModel.needToUpDate();
  }

  @override
  void deactivate() {
    print("deactivate ");
    super.deactivate();
  }

  @override
  void dispose() {
    homeViewModel.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    int counter = 0;
    return FutureBuilder(
      future: needUpdate,
      builder: (_, AsyncSnapshot asyncSnapshot) {
        print("counter$counter");
        counter++;
        if (asyncSnapshot.hasData) {
          print("in  data true");
          if (asyncSnapshot.data) {
            return AppUpdateScreen();
          } else {
            /// load  data  for  home  screen
            print("lodaing  from state");
            homeViewModel.initData(context);
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
                            itemCount: model.persons.length + 1,
                            itemBuilder: (_, index) {
                              if (index < model.persons.length) {
                                final person = model.persons[index];
                                return PersonCard(
                                  field: person.knownForDepartment ??
                                      AppStrings.defaultEmptyString,
                                  name: person.name ??
                                      AppStrings.defaultEmptyString,
                                  imageUrl:
                                      model.getImageUrl(person.profilePath),
                                  onTapped: () => model.openPersonDetailsScreen(
                                      context, index),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p28,
                                  ),
                                  child: Center(
                                    child: model.hasMoreData
                                        ? const CircularProgressIndicator()
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
          print("in waiting ");
          return const CustomProgressIndicator();
        }
      },
    );
  }
}
