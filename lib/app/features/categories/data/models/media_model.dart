import 'package:equatable/equatable.dart';

import '../../domain/entities/media.dart';

class MediaModel extends Media {
  MediaModel({
    super.id,
    super.modelType,
    super.modelId,
    super.uuid,
    super.collectionName,
    super.name,
    super.fileName,
    super.mimeType,
    super.disk,
    super.conversionsDisk,
    super.size,
    super.manipulations,
    super.responsiveImages,
    super.orderColumn,
    super.createdAt,
    super.updatedAt,
    super.url,
  });

  factory MediaModel.fromJson(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id'] != null ? map['id'] as int : null,
      modelType: map['model_type'] != null ? map['model_type'] as String : null,
      modelId: map['model_id'] != null ? map['model_id'] as int : null,
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      collectionName: map['collection_name'] != null
          ? map['collection_name'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      fileName: map['file_name'] != null ? map['file_name'] as String : null,
      mimeType: map['mime_type'] != null ? map['mime_type'] as String : null,
      disk: map['disk'] != null ? map['disk'] as String : null,
      conversionsDisk: map['conversions_disk'] != null
          ? map['conversions_disk'] as String
          : null,
      size: map['size'] != null ? map['size'] as int : null,
      manipulations: map['manipulations'] != null
          ? List<dynamic>.from(map['manipulations'])
          : null,
      responsiveImages: map['responsive_images'] != null
          ? List<dynamic>.from(map['responsive_images'])
          : null,
      orderColumn:
          map['order_column'] != null ? map['order_column'] as int : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      url: map['url'],
    );
  }
}
