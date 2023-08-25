import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_event.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_state.dart';
import 'package:flutter_project_online_shop/data/repository/purchase_cart_repository.dart';
import 'package:flutter_project_online_shop/models/purchased_product.dart';
import 'package:flutter_project_online_shop/util/payment_handler.dart';

class PurchaseCartPageBloc extends Bloc<PurchaseCartPageEvent, PurchaseCartPageState> {
  final IPurchaseCartRepository _repository;
  final PaymentHandler _paymentHandler;

  PurchaseCartPageBloc(this._repository, this._paymentHandler) : super(PurchaseCartPageInitState()) {
    on<PurchaseCartPageLoadingRequestEvent>(
      (event, emit) async {
        var response = _repository.repositoryLoadPurchasedItem();
        emit(PurchaseCartPageResponseState(response));
      },
    );
    //
    on<PurchaseCartPageBuyRequestEvent>(
      (event, emit) async {
        var purchasedProduct = PurchasedProduct(
          product: event.product,
          productColor: event.color,
          productColorName: event.colorName,
          productStorage: event.storage,
          initialPrice: event.initialPrice,
          finalPrice: event.finalPrice,
        );
        var response = await _repository.repositorySavePurchasedItem(purchasedProduct);
        emit(
          PurchaseCartPageResponseState(response),
        );
      },
    );
    //
    on<PurchaseCartPageDeleteRequestEvent>(
      (event, emit) async {
        var purchasedProduct = PurchasedProduct(
          product: event.product,
          productColor: event.color,
          productColorName: event.colorName,
          productStorage: event.storage,
          initialPrice: event.initialPrice,
          finalPrice: event.finalPrice,
        );
        var response = await _repository.repositoryDeletePurchasedItem(purchasedProduct);
        emit(
          PurchaseCartPageResponseState(response),
        );
      },
    );
    //
    on<PurchaseCartPagePaymentInitializationEvent>(
      (event, emit) async {
        _paymentHandler.initPaymentRequest();
      },
    );
    //
    on<PurchaseCartPagePaymentRequestEvent>(
      (event, emit) async {
        _paymentHandler.sendPaymentRequest(paymentAmount: event.price);
      },
    );
    //
  }
}
