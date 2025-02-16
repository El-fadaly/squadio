import 'package:squadio/services/remote_config_service/remote_config_service.dart';
import 'package:squadio/services/service_locator.dart';
import 'package:squadio/services/update_checker_service/current_app_version_service.dart';

class UpdateCheckerService {
  var remoteConfigService = serviceLocator<RemoteConfigService>();
  var currentAppVersionService = serviceLocator<CurrentAppVersionService>();

  Future<bool> checkForUpdate() async {
    try {
      await remoteConfigService.initialise();

      var current = await currentAppVersionService.getAppCurrentVersion();
      var enforced = remoteConfigService.getEnforcedVersion;

      if (enforced.isEmpty || current.isEmpty) {
        return false;
      }
      final List<dynamic> currentVersion = getListFromString(current);
      final List<dynamic> enforcedVersion = getListFromString(enforced);

      for (var i = 0; i < enforcedVersion.length; i++) {
        if (enforcedVersion[i] > currentVersion[i]) {
          return true;
        }
        if (currentVersion[i] > enforcedVersion[i]) {
          return false;
        }
      }

      return false;
    } catch (e) {
      print("exception when checking  for  updates$e ");
      return false;
    }
  }

  List<dynamic> getListFromString(String text) {
    return text
        .replaceAll(RegExp('"'), "")
        .split('.')
        .map((String number) => int.parse(number))
        .toList();
  }
}
