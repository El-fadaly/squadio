import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:squadio/business_logic/view_models/home_view_model.dart';
import 'package:squadio/config/custom_animation.dart';
import 'package:squadio/services/service_locator.dart';
import 'package:squadio/views/resources/routes_manager.dart';
import 'package:squadio/views/resources/theme_manager.dart';
import 'package:squadio/views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await setupServiceLocator();
  runApp(MyApp());
}

/// CR: it would be better if it was in style/theme folder for its own
/// the file structure`ll be better if every "resource" in different file like ALL theming in a folder & All consts ..etc
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 100)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.red
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..textColor = Colors.red
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => serviceLocator<HomeViewModel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: HomeScreen.id,
        theme: getApplicationTheme(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
