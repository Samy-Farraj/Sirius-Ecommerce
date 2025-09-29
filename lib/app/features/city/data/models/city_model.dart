import 'package:equatable/equatable.dart';

import '../../../product/data/models/pivot_model.dart';
import '../../domain/entities/city.dart';

class CityModel extends City {
  CityModel({
    super.id,
    super.name,
    super.enName,
    super.arName,
  });

  factory CityModel.fromJson(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      enName: map['en_name'] != null ? map['en_name'] as String : null,
      arName: map['ar_name'] != null ? map['ar_name'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    return data;
  }
}
