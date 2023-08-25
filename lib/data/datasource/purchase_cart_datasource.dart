import 'package:flutter_project_online_shop/models/purchased_product.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPurchaseCartDataSource {
  final purchasedProductBox = Hive.box<PurchasedProduct>('purchasedProductItems');

  Future<void> dataSourceSavePurchasedItem(PurchasedProduct purchasedProduct);
  Future<void> dataSourceDeletePurchasedItem(PurchasedProduct purchasedProduct);
}

class PurchaseCartLocalDataSource extends IPurchaseCartDataSource {
  @override
  Future<void> dataSourceSavePurchasedItem(PurchasedProduct purchasedProduct) async {
    await purchasedProductBox.add(purchasedProduct);
  }

  @override
  Future<void> dataSourceDeletePurchasedItem(PurchasedProduct purchasedProduct) async {
    for (var boxItemKey = 0; boxItemKey < purchasedProductBox.values.length; boxItemKey++) {
      bool productCheker = (purchasedProductBox.getAt(boxItemKey)!.product == purchasedProduct.product &&
          purchasedProductBox.getAt(boxItemKey)!.productColorName == purchasedProduct.productColorName &&
          purchasedProductBox.getAt(boxItemKey)!.productStorage == purchasedProduct.productStorage);
      if (productCheker) {
        await purchasedProductBox.deleteAt(boxItemKey);
      }
    }
  }
}
