import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final int? id;
  final int? companyId;
  final int? cityId;
  final String? address;
  final String? longitude;
  final String? latitude;
  final String? title;
  final String? createdAt;
  final String? updatedAt;

  const Branch({
    this.id,
    this.companyId,
    this.cityId,
    this.address,
    this.longitude,
    this.latitude,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        companyId,
        cityId,
        address,
        longitude,
        latitude,
        title,
        createdAt,
        updatedAt
      ];
}
