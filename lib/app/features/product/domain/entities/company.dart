import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final int? id;
  final int? userId;
  final String? name;
  final String? email;
  final String? phone;
  final String? description;
  final String? logo;
  final String? cover;
  final String? createdAt;
  final String? updatedAt;

  const Company({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.description,
    this.logo,
    this.cover,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        email,
        phone,
        description,
        logo,
        cover,
        createdAt,
        updatedAt,
      ];
}
