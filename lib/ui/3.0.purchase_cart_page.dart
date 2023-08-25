import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_event.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_state.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/models/purchased_product.dart';
import 'package:flutter_project_online_shop/widgets/purchase_cart_item.dart';

class PurchaseCartPage extends StatefulWidget {
  const PurchaseCartPage({super.key});

  @override
  State<PurchaseCartPage> createState() => _PurchaseCartPageState();
}

class _PurchaseCartPageState extends State<PurchaseCartPage> {
  @override
  void initState() {
    BlocProvider.of<PurchaseCartPageBloc>(context).add(
      PurchaseCartPageLoadingRequestEvent(),
    );
    BlocProvider.of<PurchaseCartPageBloc>(context).add(
      PurchaseCartPagePaymentInitializationEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<PurchaseCartPageBloc, PurchaseCartPageState>(
        builder: (context, state) {
          if (state is PurchaseCartPageInitState) {
            return const SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Loading items'),
                  ],
                ),
              ),
            );
          }
          if (state is PurchaseCartPageResponseState) {
            return state.purchasedProductListEither.fold(
              (purchasedProductListError) {
                return SafeArea(
                  child: Center(
                    child: Text(purchasedProductListError),
                  ),
                );
              },
              (purchasedProductList) {
                //----------------------------------------------------------
                return SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            _pageTitle(),
                            Flexible(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return PurchaseCartItem(
                                    product: purchasedProductList[index].product,
                                    color: purchasedProductList[index].productColor,
                                    colorName: purchasedProductList[index].productColorName,
                                    storage: purchasedProductList[index].productStorage,
                                    initialPrice: purchasedProductList[index].initialPrice,
                                    finalPrice: purchasedProductList[index].finalPrice,
                                  );
                                },
                                itemCount: purchasedProductList.length,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 70,
                          left: 0,
                          right: 0,
                          height: 53,
                          child: _getBuyButton(purchasedProductList),
                        )
                      ],
                    ),
                  ),
                );
                //----------------------------------------------------------
              },
            );
          }

          if (state is PurchaseCartPageResponseState) {
            return state.purchasedProductListEither.fold(
              (purchasedProductListError) {
                return SafeArea(
                  child: Center(
                    child: Text(purchasedProductListError),
                  ),
                );
              },
              (purchasedProductList) {
                //----------------------------------------------------------
                return SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            _pageTitle(),
                            Flexible(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return PurchaseCartItem(
                                    product: purchasedProductList[index].product,
                                    color: purchasedProductList[index].productColor,
                                    colorName: purchasedProductList[index].productColorName,
                                    storage: purchasedProductList[index].productStorage,
                                    initialPrice: purchasedProductList[index].initialPrice,
                                    finalPrice: purchasedProductList[index].finalPrice,
                                  );
                                },
                                itemCount: purchasedProductList.length,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 70,
                          left: 0,
                          right: 0,
                          height: 53,
                          child: _getBuyButton(purchasedProductList),
                        )
                      ],
                    ),
                  ),
                );
                //----------------------------------------------------------
              },
            );
          }
          return const SafeArea(
            bottom: false,
            child: Center(
              child: Text('خطای نامشخص'),
            ),
          );
        },
      ),
    );
  }

  Container _pageTitle() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 32,
        top: 20,
      ),
      height: 46,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 16,
          ),
          Image.asset('assets/images/icon_apple_blue.png'),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Text(
              'سبد خرید',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
                color: CustomColors.blue,
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }

  ElevatedButton _getBuyButton(List<PurchasedProduct> purchasedProductList) {
    var itemsPrice = purchasedProductList.fold<int>(0, (previousValue, element) => previousValue + element.finalPrice);
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<PurchaseCartPageBloc>(context).add(PurchaseCartPagePaymentRequestEvent(itemsPrice));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.green,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        itemsPrice.toString(),
        style: const TextStyle(
          fontFamily: 'SB',
          fontSize: 16,
        ),
      ),
    );
  }
}
