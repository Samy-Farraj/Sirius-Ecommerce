import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart' show compute;
import 'package:image/image.dart' as image_library;
import 'package:path_provider/path_provider.dart';

// const int compressedImageHeight = 500;
const int compressedImageQuality = 95;

///tha image utils interface that other classes calls with Compress object to
///compress the image file and returns the compressed file path
Future<String?> compressImage(CompressObject object) async {
  return compute(_decodeImage, object);
}

///returns the decided image file path
String? _decodeImage(CompressObject object) {
  final image = image_library.decodeImage(object.imageFile.readAsBytesSync());
  if (image != null) {
    final smallerImage = image_library.copyResize(image,
        height: image.height, maintainAspect: true);
    // choose the size
    // here, it will maintain aspect ratio
    final decodedImageFile = File('${object.path}${'/img_${object.rand}.jpg'}')
      ..writeAsBytesSync(image_library.encodeJpg(smallerImage,
          quality: compressedImageQuality));
    return decodedImageFile.path;
  }
  return null;
}

class CompressObject {
  File imageFile;
  String path;
  int rand;

  CompressObject(this.imageFile, this.path, this.rand);
}

Future<File> compressImageFile(File imageFile) async {
  final tempDir = await getTemporaryDirectory();
  final rand = Random().nextInt(10000);
  final CompressObject compressObject =
      CompressObject(imageFile, tempDir.path, rand);
  final String? filePath = await compressImage(compressObject);
  developer.log('new path: $filePath');
  final File compressedImageFile = File(filePath ?? '');
  return compressedImageFile;
}
