import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_state.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_state.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_event.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/models/product_details.dart';
import 'package:flutter_project_online_shop/models/product_properties.dart';
import 'package:flutter_project_online_shop/models/product_variant_type.dart';
import 'package:flutter_project_online_shop/models/product_variants.dart';
import 'package:flutter_project_online_shop/widgets/cached_image.dart';
import 'package:flutter_project_online_shop/widgets/loading_animation.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Color colorContainerStatus = Colors.black;
  String colorContainerName = 'سیاه';
  int colorPriceChange = 0;
  String storageContainerStatus = '128';
  int storagePriceChange = 0;
  String voltageContainerStatus = '50';
  String imageType = 'icon_favorite_deactive.png';
  int selectedImage = 0;
  List<String> imageList = [];
  bool explanationContainerClickCheck = false;
  bool technicalDetailsContainerClickCheck = false;
  bool commentDetailsContainerClickCheck = false;

  @override
  Widget build(BuildContext context) {
    if (imageList.isEmpty) {
      imageList.add(widget.product.getImageUrl());
    }
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductDetailPageBloc, ProductDetailPageState>(
        builder: (context, state) {
          if (state is ProductDetailPageInitState || state is ProductDetailPageLoadingState) {
            return const SafeArea(
              child: LoadingAnimation(),
            );
          }
          if (state is ProductDetailPageResponseState) {
            return state.responseCategory.fold(
              (productCategoryListError) {
                return SafeArea(
                  child: Center(
                    child: Text(
                      productCategoryListError,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
              (productCategoryList) {
                return state.responseProperties.fold(
                  (productPropertiesListError) {
                    return SafeArea(
                      child: Center(
                        child: Text(
                          productPropertiesListError,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                  (productPropertiesList) {
                    return state.responseDetail.fold(
                      (productDetailListError) {
                        return SafeArea(
                          child: Center(
                            child: Text(
                              productDetailListError,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                      (productDetailsList) {
                        return state.responseVariantType.fold(
                          (productVariantTypeListError) {
                            return SafeArea(
                              child: Center(
                                child: Text(
                                  productVariantTypeListError,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontFamily: 'SM',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          },
                          (productVariantTypeList) {
                            return state.responseVariants.fold(
                              (productVariantsListError) {
                                return SafeArea(
                                  child: Center(
                                    child: Text(
                                      productVariantsListError,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontFamily: 'SM',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              (productVariantsList) {
                                //main statebuilder widget:----------------------------------------------------------------
                                return SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 44),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          _pageTitle(productCategoryList),
                                          _getProductName(widget.product.name),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          _productView(productDetailsList),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          for (var productVariantType in productVariantTypeList) ...{
                                            _getProductVariantGenerator(
                                              productVariantType,
                                              productVariantsList,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          },
                                          _productDetailsTechnicalContainer(
                                            title: 'مشخصات فنی',
                                            productPropertiesList: productPropertiesList,
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          _productDetailsExplanationContainer(
                                            title: 'توضیحات محصول:',
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          _productDetailsCommentContainer(
                                            title: 'دیدگاه کاربران:',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          _getButtons(
                                            product: widget.product,
                                            colorPriceChange: colorPriceChange,
                                            storagePriceChange: storagePriceChange,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                //---------------------------------------------------------------- :main statebuilder widget
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Container _pageTitle(List<Category> productCategoryList) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32, top: 20),
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
          Expanded(
            child: Text(
              widget.product.findCategory(productCategoryList).title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'SB',
                fontSize: 16,
                color: CustomColors.blue,
              ),
            ),
          ),
          Image.asset('assets/images/icon_back.png'),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }

  Text _getProductName(String name) {
    return Text(
      name,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      style: const TextStyle(
        fontFamily: 'SB',
        fontSize: 16,
      ),
    );
  }

  Card _productView(List<ProductDetail> productDetailsList) {
    return Card(
      elevation: 10,
      shadowColor: CustomColors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 280,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 25,
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/icon_star.png'),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '4.6',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CachedImage(imageUrl: imageList[selectedImage]),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (imageType == 'icon_favorite_deactive.png') {
                              imageType = 'active_fav_product.png';
                            } else {
                              imageType = 'icon_favorite_deactive.png';
                            }
                          });
                        },
                        child: Image.asset(
                          'assets/images/$imageType',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 80,
                child: _getotherImages(productDetailsList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProductVariantGenerator(
    ProductVariantType productVariantType,
    List<ProductVariants> productVariantsList,
  ) {
    List<ProductVariants> thisProductVariantsList = productVariantsList
        .where((element) => element.typeId == productVariantType.id && element.productId == widget.product.id)
        .toList();
    if (thisProductVariantsList.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariantType.title,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 26,
            child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: thisProductVariantsList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        (productVariantType.id == 'wzp3vjuzqzyk6bi')
                            ? {
                                colorContainerStatus = thisProductVariantsList[index].getVariantStatus(),
                                colorContainerName = thisProductVariantsList[index].name,
                                colorPriceChange = thisProductVariantsList[index].priceChange,
                              }
                            : (productVariantType.id == '55lkmzlptkmf9mu')
                                ? {
                                    storageContainerStatus = thisProductVariantsList[index].getVariantStatus(),
                                    storagePriceChange = thisProductVariantsList[index].priceChange,
                                  }
                                : {voltageContainerStatus = thisProductVariantsList[index].getVariantStatus()};
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: (productVariantType.id == 'wzp3vjuzqzyk6bi')
                        ? _productColorContainer(
                            color: thisProductVariantsList[index].getVariantStatus(),
                            colorTitle: thisProductVariantsList[index].name,
                          )
                        : (productVariantType.id == '55lkmzlptkmf9mu')
                            ? _productStorageContainer(
                                title: thisProductVariantsList[index].value,
                              )
                            : const Text('ولتاژ خروجی'),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  AnimatedContainer _productColorContainer({required Color color, required String colorTitle}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: color == colorContainerStatus ? 76 : 26,
      height: 26,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      alignment: Alignment.center,
      child: AnimatedOpacity(
        opacity: color == colorContainerStatus ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        child: Text(
          colorTitle,
          style: TextStyle(
            color: color == Colors.white ? Colors.black : Colors.white,
            fontFamily: 'SM',
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  AnimatedContainer _productStorageContainer({
    required String title,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
        border: Border.all(
          width: storageContainerStatus == title ? 1.5 : 1,
          color: storageContainerStatus == title ? CustomColors.blue : CustomColors.grey,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(fontFamily: 'SM', fontSize: 12),
      ),
    );
  }

  Widget _productDetailsTechnicalContainer({
    required String title,
    required List<ProductProperties> productPropertiesList,
  }) {
    var thisProductPropertiesList = widget.product.findProductProperties(productPropertiesList);
    return GestureDetector(
      onTap: () {
        setState(() {
          technicalDetailsContainerClickCheck = !technicalDetailsContainerClickCheck;
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            width: 1,
            color: CustomColors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 100),
                    turns: (technicalDetailsContainerClickCheck) ? -0.25 : 0,
                    child: Image.asset('assets/images/icon_left_categroy.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 12,
                      color: CustomColors.blue,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastEaseInToSlowEaseOut,
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: technicalDetailsContainerClickCheck,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      for (var productProperty in thisProductPropertiesList) ...{
                        RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${productProperty.title} :',
                                style: const TextStyle(
                                  color: Colors.black,
                                  height: 1.8,
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: productProperty.value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  height: 1.8,
                                  fontFamily: 'SM',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      }
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productDetailsExplanationContainer({
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          explanationContainerClickCheck = !explanationContainerClickCheck;
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            width: 1,
            color: CustomColors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 100),
                    turns: (explanationContainerClickCheck) ? -0.25 : 0,
                    child: Image.asset('assets/images/icon_left_categroy.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 12,
                      color: CustomColors.blue,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastEaseInToSlowEaseOut,
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: explanationContainerClickCheck,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product.description,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          height: 1.8,
                          fontFamily: 'SM',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _productDetailsCommentContainer({
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            commentDetailsContainerClickCheck = !commentDetailsContainerClickCheck;
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            width: 1,
            color: CustomColors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 100),
                    turns: (commentDetailsContainerClickCheck) ? -0.25 : 0,
                    child: Image.asset('assets/images/icon_left_categroy.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 12,
                      color: CustomColors.blue,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<ProductDetailPageCommentsBloc, ProductDetailPageCommentsState>(
                    builder: (context, state) {
                      if (state is ProductDetailPageCommentsLoadingState) {
                        return const Text(
                          '...',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                          ),
                        );
                      }
                      if (state is ProductDetailPageCommentsResponseState) {
                        return state.commentListEither.fold(
                          (commentListError) => const SizedBox(),
                          (commentList) => Text(
                            (commentList.isEmpty) ? '(دیدگاهی وجود ندارد)' : '(${commentList.length} دیدگاه)',
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  //
                  Text(
                    title,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastEaseInToSlowEaseOut,
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: commentDetailsContainerClickCheck,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      _getCommentSection(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCommentSection() {
    return BlocBuilder<ProductDetailPageCommentsBloc, ProductDetailPageCommentsState>(
      builder: (context, state) {
        if (state is ProductDetailPageCommentsLoadingState) {
          return const Text(
            'در حال دریافت دیدگاه ها',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
            ),
          );
        }
        if (state is ProductDetailPageCommentsResponseState) {
          return state.commentListEither.fold(
            (commentListError) => const SizedBox(),
            (commentList) => Column(
              children: [
                ...List.generate(
                  commentList.length,
                  (index) => Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          if (commentList[index].user.getAvatarUrl().endsWith('/')) ...{
                            Image.asset(
                              'assets/images/icon_profile.png',
                              height: 30,
                              width: 30,
                              scale: 1.1,
                            ),
                          } else ...{
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CachedImage(
                                borderRaduis: 6,
                                imageUrl: commentList[index].user.getAvatarUrl(),
                              ),
                            ),
                          },
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            (commentList[index].user.name == '')
                                ? commentList[index].user.username
                                : commentList[index].user.name,
                            style: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            commentList[index].time,
                            style: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            commentList[index].date,
                            style: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35),
                        child: Text(
                          commentList[index].text,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.grey,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Text(
          'خطای نامشخص هنگام دریافت دیدگاه ها',
          style: TextStyle(
            fontFamily: 'SM',
            fontSize: 12,
          ),
        );
      },
    );
  }

  Row _getButtons({
    required Product product,
    required int colorPriceChange,
    required int storagePriceChange,
  }) {
    int price = product.price + colorPriceChange + storagePriceChange;
    int priceWithDiscount = price + product.discountPrice;
    int offPercentage = ((price - priceWithDiscount) / price * 100).round();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _button(
          color: CustomColors.green,
          child: Row(
            children: [
              const Text(
                'تومان',
                style: TextStyle(
                  fontFamily: 'SM',
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price.toString(),
                    style: const TextStyle(
                      fontFamily: 'SM',
                      color: Colors.white,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                    ),
                  ),
                  Text(
                    priceWithDiscount.toString(),
                    style: const TextStyle(
                      fontFamily: 'SM',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 15,
                width: 27,
                decoration: const BoxDecoration(
                  color: CustomColors.red,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '%${offPercentage.toString()}',
                  style: const TextStyle(
                    fontFamily: 'SB',
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        _button(
          onTap: () {
            context.read<PurchaseCartPageBloc>().add(
                  PurchaseCartPageBuyRequestEvent(
                    product: widget.product,
                    color: colorContainerStatus,
                    colorName: colorContainerName,
                    storage: storageContainerStatus,
                    initialPrice: price,
                    finalPrice: priceWithDiscount,
                  ),
                );
          },
          color: CustomColors.blue,
          child: const Text(
            'افزودن به سبد خرید',
            style: TextStyle(
              fontFamily: 'SB',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getotherImages(List<ProductDetail> productDetailList) {
    if (imageList.length == 1) {
      var list = productDetailList.where((element) => element.productId == widget.product.id).toList();
      var imageListNewImages = list.map<String>((element) => element.getImageUrl()).toList();
      imageList.addAll(imageListNewImages);
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedImage = index;
            });
          },
          child: Container(
            height: 70,
            width: 70,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                  width: 1,
                  color: CustomColors.grey,
                ),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CachedImage(imageUrl: imageList[index]),
            ),
          ),
        );
      },
      itemCount: imageList.length,
    );
  }

  Widget _button({
    required Color color,
    Widget child = const SizedBox(),
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const SizedBox(
            width: 150,
            height: 58,
          ),
          Container(
            height: 47,
            width: 130,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
          ),
          Positioned(
            top: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 53,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                alignment: Alignment.center,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
