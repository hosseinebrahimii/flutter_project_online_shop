import 'package:dartz/dartz.dart';

import 'package:flutter_project_online_shop/data/datasource/purchase_cart_datasource.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/purchased_product.dart';

abstract class IPurchaseCartRepository {
  Either<String, List<PurchasedProduct>> repositoryLoadPurchasedItem();

  Future<Either<String, List<PurchasedProduct>>> repositorySavePurchasedItem(PurchasedProduct purchasedProduct);

  Future<Either<String, List<PurchasedProduct>>> repositoryDeletePurchasedItem(PurchasedProduct purchasedProduct);
}

class PurchaseCartRepository extends IPurchaseCartRepository {
  final IPurchaseCartDataSource _dataSource = locator.get();

  @override
  Either<String, List<PurchasedProduct>> repositoryLoadPurchasedItem() {
    try {
      var purchasedProductList = _dataSource.purchasedProductBox.values.toList();

      return right(purchasedProductList);
    } catch (ex) {
      return left('خطا هنگام ذخیره دیتا');
    }
  }

  @override
  Future<Either<String, List<PurchasedProduct>>> repositorySavePurchasedItem(PurchasedProduct purchasedProduct) async {
    await _dataSource.dataSourceSavePurchasedItem(purchasedProduct);
    return repositoryLoadPurchasedItem();
  }

  @override
  Future<Either<String, List<PurchasedProduct>>> repositoryDeletePurchasedItem(
      PurchasedProduct purchasedProduct) async {
    await _dataSource.dataSourceDeletePurchasedItem(purchasedProduct);
    return repositoryLoadPurchasedItem();
  }
}
