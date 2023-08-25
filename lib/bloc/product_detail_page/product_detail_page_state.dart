import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/models/product_details.dart';
import 'package:flutter_project_online_shop/models/product_properties.dart';
import 'package:flutter_project_online_shop/models/product_variant_type.dart';
import 'package:flutter_project_online_shop/models/product_variants.dart';

abstract class ProductDetailPageState {}

class ProductDetailPageInitState extends ProductDetailPageState {}

class ProductDetailPageLoadingState extends ProductDetailPageState {}

class ProductDetailPageResponseState extends ProductDetailPageState {
  Either<String, List<Category>> responseCategory;
  Either<String, List<ProductDetail>> responseDetail;
  Either<String, List<ProductVariantType>> responseVariantType;
  Either<String, List<ProductVariants>> responseVariants;
  Either<String, List<ProductProperties>> responseProperties;

  ProductDetailPageResponseState(
    this.responseCategory,
    this.responseDetail,
    this.responseVariantType,
    this.responseVariants,
    this.responseProperties,
  );
}
