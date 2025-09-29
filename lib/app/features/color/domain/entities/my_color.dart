import 'package:equatable/equatable.dart';

class MyColor extends Equatable {
  final int? id;
  final MyColor? combinedWith;
  final String? name;
  final String? hashcode;
  final String? createdAt;
  final String? updatedAt;

  @override
  List<Object?> get props => [
        id,
        combinedWith,
        name,
        hashcode,
        createdAt,
        updatedAt,
      ];

  MyColor({
    this.id,
    this.combinedWith,
    this.name,
    this.hashcode,
    this.createdAt,
    this.updatedAt,
  });
}
