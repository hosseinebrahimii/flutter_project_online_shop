import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_event.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/ui/1.2.product_details_page.dart';
import 'package:flutter_project_online_shop/widgets/show_case_item.dart';

class ProductListPage extends StatelessWidget {
  final Category category;
  final List<Product> productList;

  const ProductListPage({
    super.key,
    required this.category,
    required this.productList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _pageTitle(),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 44, right: 44, bottom: 44),
              sliver: _productsList(),
            ),
          ],
        ),
      ),
    );
  }

  Container _pageTitle() {
    return Container(
      margin: const EdgeInsets.only(left: 44, right: 44, bottom: 32, top: 20),
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
          const Icon(
            Icons.filter_alt_rounded,
            color: CustomColors.blue,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              category.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
                color: CustomColors.blue,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset('assets/images/icon_back.png'),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }

  SliverGrid _productsList() {
    List<Product> thisCategoryProducts;
    if (category.id == '78q8w901e6iipuk') {
      thisCategoryProducts = productList;
    } else {
      thisCategoryProducts = productList.where((element) => element.category == category.id).toList();
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    product: thisCategoryProducts[index],
                  ),
                ),
              );
              BlocProvider.of<ProductDetailPageCommentsBloc>(context).add(
                ProductDetailPageCommentsRequestEvent(
                  thisCategoryProducts[index],
                ),
              );
            },
            child: ShowCaseItem(
              product: thisCategoryProducts[index],
            ),
          );
        },
        childCount: thisCategoryProducts.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        mainAxisExtent: 206,
        crossAxisSpacing: 20,
      ),
    );
  }
}
