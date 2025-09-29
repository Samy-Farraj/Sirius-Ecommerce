import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/dashboard/domain/entities/product_sale.dart';

import '../../data/models/report_item_model.dart';

class Statistics extends Equatable {
  int? totalAmount;
  int? totalProducts;
  int? totalAmountDifference;
  int? totalProductsDifference;
  List<ReportItem>? incomeOverview;
  List<ReportItem>? salesReport;
  List<ProductSale>? productSales;

  Statistics({
    this.totalAmount,
    this.totalAmountDifference,
    this.totalProductsDifference,
    this.totalProducts,
    this.incomeOverview,
    this.salesReport,
    this.productSales,
  });

  @override
  List<Object?> get props => [
        totalAmount,
        totalAmountDifference,
        totalProductsDifference,
        totalProducts,
        incomeOverview,
        salesReport,
        productSales,
      ];
}
