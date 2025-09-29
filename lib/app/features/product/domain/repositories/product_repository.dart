import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart';
import 'package:sirius/app/features/size/domain/entities/size_entity.dart';
import 'package:sirius/src/error/failure.dart';

import '../entities/paginated_product.dart';
import '../entities/product.dart';
import '../usecases/get_products_use_case.dart';

abstract class BaseProductRepository {
  Future<Either<Failure, PaginatedProduct>> getProducts(
      GetProductParams params);

  Future<Either<Failure, Product>> showProductDetailsById(String productId);
  Future<Either<Failure, Unit>> deleteProductById(String productId);
  Future<Either<Failure, Unit>> createNewProduct(NewProductParameter parameter);
  Future<Either<Failure, Unit>> editProduct(NewProductParameter parameter);
}
