import 'package:osm/app/features/app/domain/entities/app.dart';
import 'package:osm/app/features/app/domain/entities/app.dart';

class AppModel extends App {
  const AppModel({
    super.id,
    super.name,
    super.description,
    super.versionName,
    super.versionCode,
    super.isRequired,
    super.platform,
    super.delayToRequire,
    super.updatedAt,
    super.createdAt,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'versionName': versionName,
      'versionCode': versionCode,
      'isRequired': isRequired,
      'platform': platform,
      'delayToRequire': delayToRequire,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory AppModel.fromJson(Map<String, dynamic> map) {
    return AppModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      versionName:
          map['version_name'] != null ? map['version_name'] as String : null,
      versionCode:
          map['version_code'] != null ? map['version_code'] as int : null,
      isRequired:
          map['version_code'] != null ? map['is_required'] as bool : null,
      platform: AppPlatform.values.firstWhere((e) {
        return (map['platform'] as String).contains(e.name);
      }),
      delayToRequire: map['delay_to_require'] != null
          ? map['delay_to_require'] as int
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }
}
