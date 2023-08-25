import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/models/purchased_product.dart';

abstract class PurchaseCartPageState {}

class PurchaseCartPageInitState extends PurchaseCartPageState {}

class PurchaseCartPageResponseState extends PurchaseCartPageState {
  final Either<String, List<PurchasedProduct>> purchasedProductListEither;
  PurchaseCartPageResponseState(this.purchasedProductListEither);
}
