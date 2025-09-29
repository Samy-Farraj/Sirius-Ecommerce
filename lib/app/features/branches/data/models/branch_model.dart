import 'package:equatable/equatable.dart';

import '../../domain/entities/branch.dart';

class BranchModel extends Branch {
  BranchModel({
    super.id,
    super.companyId,
    super.cityId,
    super.address,
    super.longitude,
    super.latitude,
    super.title,
    super.createdAt,
    super.updatedAt,
  });

  factory BranchModel.fromJson(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'] != null ? map['id'] as int : null,
      companyId: map['company_id'] != null ? map['company_id'] as int : null,
      cityId: map['city_id'] != null ? map['city_id'] as int : null,
      address: map['address'] != null ? map['address'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (companyId != null) data['companyId'] = companyId;
    if (cityId != null) data['cityId'] = cityId;
    if (address != null) data['address'] = address;
    if (longitude != null) data['longitude'] = longitude;
    if (latitude != null) data['latitude'] = latitude;
    if (title != null) data['title'] = title;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (updatedAt != null) data['updatedAt'] = updatedAt;
    return data;
  }
}
