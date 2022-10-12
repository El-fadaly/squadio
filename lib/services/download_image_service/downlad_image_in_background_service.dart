import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:squadio/services/download_image_service/download_image_service.dart';

class DownloadImageInBackgroundService implements DownloadImageService {
  var isolate;

  @pragma('vm:entry-point')
  static void downloadBy(Map<String, dynamic> args) async {
    try {
      /// create   image  temporary file
      File saveFile = File(args['path'] + basename(args['url']));

      /// download image from url
      await Dio().download(args['url'], saveFile.path);

      /// save image  in permanent file
      await ImageGallerySaver.saveFile(saveFile.path, isReturnPathOfIOS: true);

      /// send message to main isolate that image is saved
      args['port'].send(1);
    } catch (e) {
      print(" exception in  getting  download $e");
      args['port'].send(0);
    } finally {
      /// kill current isolate as it isn't needed any more to save memory
      print("in finally before killing isolate");
      FlutterIsolate.current.kill();
      print("in finally after killing isolate");
    }
  }

  @override
  Future<bool> downloadImageByUrl({url}) async {
    var port = ReceivePort();

    /// getting temporary files directory as isolate cant get that  directory
    var path = (await getTemporaryDirectory()).path;

    isolate = FlutterIsolate.spawn(
      DownloadImageInBackgroundService.downloadBy,
      {"url": url, 'path': path, 'port': port.sendPort},
    );

    /// listening to secondary isolate messages
    final Completer<bool> c = Completer<bool>();
    port.listen(
      (msg) {
        print("Received message from isolate $msg");
        if (msg == 1) {
          c.complete(true);
        } else {
          c.complete(false);
        }
      },
    );
    return c.future;
  }
}
