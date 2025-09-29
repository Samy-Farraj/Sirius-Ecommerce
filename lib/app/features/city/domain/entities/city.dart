import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/product/domain/entities/pivot.dart';

class City extends Equatable {
  int? id;
  String? name;
  String? enName;
  String? arName;

  @override
  List<Object?> get props => [
        id,
        name,
        arName,
        enName,
      ];

  City({
    this.id,
    this.name,
    this.enName,
    this.arName,
  });
}
