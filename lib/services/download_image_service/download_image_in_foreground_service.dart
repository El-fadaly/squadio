import 'package:gallery_saver/gallery_saver.dart';
import 'package:squadio/services/download_image_service/download_image_service.dart';

class DownloadImageInForeground implements DownloadImageService {
  @override
  Future<bool> downloadImageByUrl({url}) async {
    try {
      var response = await GallerySaver.saveImage(url);
      return response ?? false;
    } catch (e) {
      print("exception in downloading  image  $e");
      return false;
    }
  }
}
