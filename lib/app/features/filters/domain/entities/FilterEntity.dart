import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/product/data/models/PriceRangeFilterModel.dart';
import '../../../product/data/models/SubCategoryFilterModel.dart';
import '../../../product/domain/entities/company.dart';
import '../../../size/domain/entities/size_entity.dart';

class FilterEntity extends Equatable {
  final List<String>? genders;
  final List<MyColor>? colors;
  final List<SizeEntity>? sizes;
  final List<Company>? companies;
  final List<SubCategoryFilterModel>? subCategories;
  final PriceRangeFilterModel? priceRange;

  @override
  List<Object?> get props => [
        genders,
        colors,
        sizes,
        companies,
        subCategories,
        priceRange,
      ];

  FilterEntity({
    this.genders,
    this.colors,
    this.sizes,
    this.companies,
    this.subCategories,
    this.priceRange,
  });
}
