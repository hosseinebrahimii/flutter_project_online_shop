import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/models/product.dart';

abstract class PurchaseCartPageEvent {}

class PurchaseCartPageLoadingRequestEvent extends PurchaseCartPageEvent {}

class PurchaseCartPageBuyRequestEvent extends PurchaseCartPageEvent {
  Product product;
  Color color;
  String colorName;
  String storage;
  int initialPrice;
  int finalPrice;

  PurchaseCartPageBuyRequestEvent({
    required this.product,
    required this.color,
    required this.colorName,
    required this.storage,
    required this.initialPrice,
    required this.finalPrice,
  });
}

class PurchaseCartPageDeleteRequestEvent extends PurchaseCartPageEvent {
  Product product;
  Color color;
  String colorName;
  String storage;
  int initialPrice;
  int finalPrice;

  PurchaseCartPageDeleteRequestEvent({
    required this.product,
    required this.color,
    required this.colorName,
    required this.storage,
    required this.initialPrice,
    required this.finalPrice,
  });
}

class PurchaseCartPagePaymentInitializationEvent extends PurchaseCartPageEvent {}

class PurchaseCartPagePaymentRequestEvent extends PurchaseCartPageEvent {
  int price;
  PurchaseCartPagePaymentRequestEvent(this.price);
}
