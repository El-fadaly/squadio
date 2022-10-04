import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:squadio/views/resources/constants_manager.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  final defaults = <String, dynamic>{AppConstants.remoteConfigKey: "1.0.1"};

  String get getEnforcedVersion =>
      _remoteConfig.getString(AppConstants.remoteConfigKey);

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } catch (exception) {
      print(
          'Unable to fetch remote config. Cached or default values will be used $exception)');
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }
}
