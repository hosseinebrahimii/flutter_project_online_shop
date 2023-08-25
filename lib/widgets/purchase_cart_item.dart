import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_event.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/widgets/cached_image.dart';

class PurchaseCartItem extends StatelessWidget {
  const PurchaseCartItem({
    super.key,
    required this.product,
    required this.color,
    required this.colorName,
    required this.storage,
    required this.initialPrice,
    required this.finalPrice,
  });

  final Product product;
  final Color color;
  final String colorName;
  final String storage;
  final int initialPrice;
  final int finalPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 10,
      shadowColor: CustomColors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _getProductImage(product),
                      const SizedBox(
                        width: 20,
                      ),
                      _getProductDetails(
                        context,
                        product,
                        color,
                        colorName,
                        storage,
                        initialPrice,
                        finalPrice,
                      ),
                    ],
                  ),
                ),
                const DottedLine(
                  dashColor: CustomColors.grey,
                  dashGapLength: 3,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '$finalPrice تومان',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontFamily: 'SM',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Padding _getProductImage(Product product) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: SizedBox(
      height: 85,
      child: CachedImage(
        imageUrl: product.getImageUrl(),
      ),
    ),
  );
}

Column _getProductDetails(
  BuildContext context,
  Product product,
  Color color,
  String colorName,
  String storage,
  int initialPrice,
  int finalPrice,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 195,
        child: Text(
          product.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'SB',
            fontSize: 16,
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      const Text(
        'گارانتی 18 ماهه مدیا پردازش',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: CustomColors.grey,
          fontFamily: 'SM',
          fontSize: 12,
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Row(
        children: [
          Text(
            initialPrice.toString(),
            style: const TextStyle(
              fontFamily: 'SM',
              color: CustomColors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            height: 15,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: CustomColors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Text(
              '%${((initialPrice - finalPrice) / initialPrice * 100).round()}',
              style: const TextStyle(
                fontFamily: 'SB',
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          _outlinedContainer(
            height: 24,
            width: 95,
            child: Text(
              '$storage گیگابایت',
              style: const TextStyle(
                fontFamily: 'SB',
                color: CustomColors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          _outlinedContainer(
            width: 95,
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  colorName,
                  style: const TextStyle(
                    fontFamily: 'SB',
                    color: CustomColors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: color,
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          _outlinedContainer(
            width: 50,
            height: 24,
            child: Row(
              children: [
                const Spacer(),
                const Text(
                  '1',
                  style: TextStyle(
                    fontFamily: 'SB',
                    color: CustomColors.grey,
                    fontSize: 12,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                Image.asset(
                  'assets/images/icon_options.png',
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          _outlinedContainer(
            width: 70,
            height: 24,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  size: 15,
                  color: CustomColors.grey,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'ویرایش',
                  style: TextStyle(
                    fontFamily: 'SB',
                    color: CustomColors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<PurchaseCartPageBloc>(context).add(
                PurchaseCartPageDeleteRequestEvent(
                  product: product,
                  color: color,
                  colorName: colorName,
                  storage: storage,
                  initialPrice: initialPrice,
                  finalPrice: finalPrice,
                ),
              );
            },
            child: _outlinedContainer(
              width: 65,
              height: 24,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_forever,
                    color: CustomColors.grey,
                    size: 16,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'حذف',
                    style: TextStyle(
                      fontFamily: 'SB',
                      color: CustomColors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ],
  );
}

Container _outlinedContainer({required double width, required double height, Widget child = const SizedBox()}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: CustomColors.grey,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: child,
    ),
  );
}
