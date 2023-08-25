import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/models/category.dart';

abstract class CategoryPageState {}

class CategoryPageInitState extends CategoryPageState {}

class CategoryPageLoadingState extends CategoryPageState {}

class CategoryPageResponseState extends CategoryPageState {
  Either<String, List<Category>> response;
  CategoryPageResponseState(this.response);
}
