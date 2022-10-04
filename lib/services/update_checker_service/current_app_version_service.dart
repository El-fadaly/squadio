import 'package:package_info_plus/package_info_plus.dart';

class CurrentAppVersionService {
  Future<String> getAppCurrentVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      print("exception when getting  current  version ");
      return "";
    }
  }
}
