import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_state.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/models/banner.dart';
import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/models/enum_product_popularity.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/ui/1.1.product_list_page.dart';
import 'package:flutter_project_online_shop/widgets/banner_slider.dart';
import 'package:flutter_project_online_shop/widgets/cached_image.dart';
import 'package:flutter_project_online_shop/widgets/category_horizontal_list.dart';
import 'package:flutter_project_online_shop/widgets/item_showcase_list.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  //homepage bloc was initialized in main.dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return _getHomePageContent(state);
        },
      ),
    );
  }

  Widget _getHomePageContent(HomePageState state) {
    if (state is HomePageInitState || state is HomePageLoadingState) {
      return const SafeArea(
        child: Center(
          child: SizedBox(
            height: 60,
            width: 60,
            child: LoadingIndicator(
              indicatorType: Indicator.ballRotateChase,
              colors: [CustomColors.blue],
            ),
          ),
        ),
      );
    }
    if (state is HomePageResponseState) {
      return state.bannerList.fold(
        (bannersListError) {
          return SafeArea(
            child: Center(
              child: Text(bannersListError),
            ),
          );
        },
        (bannersList) {
          return state.categoryList.fold(
            (categoryListError) {
              return SafeArea(
                child: Center(
                  child: Text(categoryListError),
                ),
              );
            },
            (categoryList) {
              return state.productList.fold(
                (productListError) {
                  return SafeArea(
                    child: Center(
                      child: Text(productListError),
                    ),
                  );
                },
                (productList) {
                  //main code ----------------------------------------------------
                  return SafeArea(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        _getSearchBox(),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              _getBannerView(bannersList),
                              const SizedBox(
                                height: 20,
                              ),
                              _getCategoryHorizontalListView(
                                categoryList,
                                productList,
                              ),
                              _getItemShowCaseList(
                                title: 'پرفروش ترین ها',
                                productList: productList,
                                productType: Popularity.bestSeller,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _getItemShowCaseList(
                                title: 'پربازدید ترین ها',
                                productList: productList,
                                productType: Popularity.hottest,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                  //---------------------------------------------------- main code
                },
              );
            },
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          'خطا هنگام دریافت اطلاعات',
          style: TextStyle(
            color: CustomColors.blue,
          ),
        ),
      );
    }
  }
}

SliverToBoxAdapter _getSearchBox() {
  return SliverToBoxAdapter(
    child: Container(
      margin: const EdgeInsets.only(
        left: 44,
        right: 44,
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
          const TextField(
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'جستجوی محصولات',
              hintStyle: TextStyle(
                color: CustomColors.grey,
                fontFamily: 'SB',
                fontSize: 16,
              ),
              hintTextDirection: TextDirection.rtl,
              constraints: BoxConstraints(maxWidth: 213),
              border: InputBorder.none,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset('assets/images/icon_search.png'),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    ),
  );
}

Widget _getBannerView(List<Banners> bannersList) {
  return BannerSlider(
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: CachedImage(
          imageUrl: bannersList[index].getImageUrl(),
          borderRaduis: 15,
        ),
      );
    },
  );
}

Widget _getCategoryHorizontalListView(List<Category> categoryList, List<Product> productList) {
  return CategoryHorizontalList(
    itemCount: categoryList.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListPage(
                category: categoryList[index],
                productList: productList,
              ),
            ),
          );
        },
        child: _getHorizontalCategoryListIconTitle(
          color: categoryList[index].getColor(),
          title: categoryList[index].title,
          child: Transform.scale(
            scale: 0.4,
            child: CachedImage(
              imageUrl: categoryList[index].getIcon(),
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    },
  );
}

Widget _getHorizontalCategoryListIconTitle({required title, required child, Color color = Colors.red}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: ShapeDecoration(
            color: color,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            shadows: [
              BoxShadow(
                color: color,
                spreadRadius: -12,
                blurRadius: 40,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: child,
        ),
        //
        //
        const SizedBox(
          height: 10,
        ),
        //
        //
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'SB',
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget _getItemShowCaseList({
  required String title,
  required List<Product> productList,
  Popularity? productType,
}) {
  return ItemShowCaseList(
    title: title,
    productList: productList,
    productType: productType,
  );
}
