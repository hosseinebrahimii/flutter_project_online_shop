import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/models/banner.dart';
import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/models/product.dart';

abstract class HomePageState {}

class HomePageInitState extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageResponseState extends HomePageState {
  Either<String, List<Banners>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;

  HomePageResponseState(this.bannerList, this.categoryList, this.productList);
}
