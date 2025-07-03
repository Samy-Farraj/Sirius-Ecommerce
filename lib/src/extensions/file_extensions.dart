import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../utils/image_utils.dart';

extension FileExtension on File {
  Future<String> toBase64() async {
    final compressedImage = await compressImageFile(this);
    Uint8List imageBytes = await compressedImage.readAsBytes();
    final base64Image = base64.encode(imageBytes);
    return base64Image;
  }

  String name() {
    final path = this.path;
    final name = path.split('/').last;
    return name;
  }
}
