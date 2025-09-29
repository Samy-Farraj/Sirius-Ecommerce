import 'package:equatable/equatable.dart';

import 'media.dart';

class Image extends Equatable {
  String original;
  String thumbnail;
  String imageDefault;

  @override
  List<Object> get props => [
        original,
        thumbnail,
        imageDefault,
      ];

  Image({
    required this.original,
    required this.thumbnail,
    required this.imageDefault,
  });
}
