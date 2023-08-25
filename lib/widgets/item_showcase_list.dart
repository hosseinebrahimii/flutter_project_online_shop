import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/models/enum_product_popularity.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/ui/1.2.product_details_page.dart';
import 'package:flutter_project_online_shop/widgets/show_case_item.dart';

class ItemShowCaseList extends StatefulWidget {
  const ItemShowCaseList({
    super.key,
    required this.title,
    this.productList,
    this.productType,
  });

  final String title;
  final List<Product>? productList;
  final Popularity? productType;

  @override
  State<ItemShowCaseList> createState() => _ItemShowCaseListState();
}

class _ItemShowCaseListState extends State<ItemShowCaseList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _showCaseTitles(title: widget.title),
        const SizedBox(
          height: 20,
        ),
        _showCaseList(productList: widget.productList, productType: widget.productType),
      ],
    );
  }

  Widget _showCaseTitles({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Image.asset('assets/images/icon_left_categroy.png'),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'مشاهده همه',
            style: TextStyle(
              fontFamily: 'SB',
              color: CustomColors.blue,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'SB',
              color: CustomColors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showCaseList({List<Product>? productList, Popularity? productType}) {
    var list = typeChecker(productType);
    return SizedBox(
      height: 206,
      child: (productList != null)
          ? ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 34),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: list[index],
                          ),
                        ),
                      );
                    },
                    child: ShowCaseItem(
                      product: list[index],
                    ),
                  ),
                );
              },
              itemCount: list!.length,
            )
          : Container(
              height: 206,
              width: 160,
              padding: const EdgeInsets.symmetric(horizontal: 34),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  List<Product>? typeChecker(Popularity? productType) {
    if (productType != null) {
      return widget.productList!.where((element) => element.getPopularity() == productType).toList();
    }
    return widget.productList;
  }
}
