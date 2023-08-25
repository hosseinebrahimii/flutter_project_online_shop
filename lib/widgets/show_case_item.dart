import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/widgets/cached_image.dart';

class ShowCaseItem extends StatelessWidget {
  const ShowCaseItem({
    Key? key,
    this.favorite = false,
    required this.product,
  }) : super(key: key);

  final bool favorite;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      width: 160,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: CachedImage(
                  imageUrl: product.getImageUrl(),
                ),
              ),
              Positioned(
                top: 0,
                right: 10,
                child: Image.asset(
                  (favorite) ? 'assets/images/active_fav_product.png' : 'assets/images/icon_favorite_deactive.png',
                  width: 24,
                  height: 24,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 10,
                child: Container(
                  width: 25,
                  height: 15,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: CustomColors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    '${product.getOffCount().toString()}%',
                    style: const TextStyle(
                      fontFamily: 'SB',
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'SM',
                fontSize: 14,
              ),
            ),
          ),
          Container(
            height: 53,
            decoration: const BoxDecoration(
                color: CustomColors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.blue,
                    blurRadius: 25,
                    spreadRadius: -12,
                    offset: Offset(0, 15),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  const Text(
                    'تومان',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        product.getPriceWithDiscount().toString(),
                        style: const TextStyle(
                          fontFamily: 'SM',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/icon_right_arrow_cricle.png',
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
