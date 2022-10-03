import 'package:gallery_saver/gallery_saver.dart';

Future<bool> downloadImageByUrl(profilePath) async {
  try {
    var response = await GallerySaver.saveImage(
        'http://image.tmdb.org/t/p/original$profilePath');
    return response ?? false;
  } catch (e) {
    print("exception in downloading  image  $e");
    return false;
  }
}
