import 'package:equatable/equatable.dart';

import '../../domain/entities/image.dart';

class ImageModel extends Image {
  ImageModel({
    required super.original,
    required super.thumbnail,
    required super.imageDefault,
  });

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      original: map['original'] as String,
      thumbnail: map['thumbnail'] as String,
      imageDefault: map['default'] as String,
    );
  }
}
