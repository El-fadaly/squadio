import 'package:gallery_saver/gallery_saver.dart';
import 'package:squadio/views/resources/constants_manager.dart';

Future<bool> downloadImageByUrl(profilePath) async {
  try {
    var response = await GallerySaver.saveImage(
        '${AppConstants.imageDetailsUrl}$profilePath');
    return response ?? false;
  } catch (e) {
    print("exception in downloading  image  $e");
    return false;
  }
}
