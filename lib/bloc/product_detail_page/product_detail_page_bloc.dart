import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_event.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_state.dart';
import 'package:flutter_project_online_shop/data/repository/category_repository.dart';
import 'package:flutter_project_online_shop/data/repository/product_all_repository.dart';

class ProductDetailPageBloc extends Bloc<ProductDetailPageEvent, ProductDetailPageState> {
  final IProductAllRepository _repository;
  final ICategoryRepository _repositoryCategory;

  ProductDetailPageBloc(this._repository, this._repositoryCategory) : super(ProductDetailPageInitState()) {
    on<ProductDetailPageRequestEvent>(
      (event, emit) async {
        emit(ProductDetailPageLoadingState());
        var responseCategory = await _repositoryCategory.repositoryGetCategoryList();
        var responseDetails = await _repository.repositoryGetProductDetailList();
        var responseVariantType = await _repository.repositoryGetProductVariantTypeList();
        var responseVariants = await _repository.repositoryGetProductVariantsList();
        var responseProperties = await _repository.repositoryGetProductPropertiesList();

        emit(
          ProductDetailPageResponseState(
            responseCategory,
            responseDetails,
            responseVariantType,
            responseVariants,
            responseProperties,
          ),
        );
      },
    );
  }
}
