import 'package:sirius/app/features/dashboard/data/models/product_sale_model.dart';
import 'package:sirius/app/features/dashboard/data/models/report_item_model.dart';

import '../../domain/entities/product_sale.dart';
import '../../domain/entities/statistics.dart';

class StatisticsModel extends Statistics {
  StatisticsModel({
    super.totalAmount,
    super.totalAmountDifference,
    super.totalProductsDifference,
    super.totalProducts,
    super.incomeOverview,
    super.salesReport,
    super.productSales,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> map) {
    return StatisticsModel(
      totalAmount:
          map['total_amount'] != null ? map['total_amount'] as int : null,
      totalAmountDifference: map['total_amount_difference'] != null
          ? map['total_amount_difference'] as int
          : null,
      totalProductsDifference: map['total_products_difference'] != null
          ? map['total_products_difference'] as int
          : null,
      totalProducts:
          map['total_products'] != null ? map['total_products'] as int : null,
      incomeOverview: map['income_overview'] != null
          ? List<ReportItem>.from((map['income_overview'] as List)
              .map((x) => ReportItem.fromJson(x as Map<String, dynamic>)))
          : null,
      salesReport: map['sales_report'] != null
          ? List<ReportItem>.from((map['sales_report'] as List)
              .map((x) => ReportItem.fromJson(x as Map<String, dynamic>)))
          : null,
      productSales: map['product_sales'] != null
          ? List<ProductSale>.from((map['product_sales'] as List)
              .map((x) => ProductSaleModel.fromJson(x as Map<String, dynamic>)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (totalAmount != null) data['total_amount'] = totalAmount;
    if (totalAmountDifference != null)
      data['total_amount_difference'] = totalAmountDifference;
    if (totalProductsDifference != null)
      data['total_products_difference'] = totalProductsDifference;
    if (totalProducts != null) data['total_products'] = totalProducts;
    if (incomeOverview != null) {
      data['income_overview'] = incomeOverview!.map((x) => x.toMap()).toList();
    }
    if (salesReport != null) {
      data['sales_report'] = salesReport!.map((x) => x.toMap()).toList();
    }

    return data;
  }
}
