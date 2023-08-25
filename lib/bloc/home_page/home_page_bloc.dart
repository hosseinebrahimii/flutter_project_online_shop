import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_event.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_state.dart';
import 'package:flutter_project_online_shop/data/repository/banner_repository.dart';
import 'package:flutter_project_online_shop/data/repository/category_repository.dart';
import 'package:flutter_project_online_shop/data/repository/product_all_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final IBannerRepository _bannerRepository;
  final ICategoryRepository _categoryRepository;
  final IProductAllRepository _productRepository;

  HomePageBloc(this._bannerRepository, this._categoryRepository, this._productRepository) : super(HomePageInitState()) {
    on<HomePageRequestEvent>(
      (event, emit) async {
        emit(HomePageLoadingState());
        var bannerList = await _bannerRepository.repositoryGetBannerList();
        var categoryList = await _categoryRepository.repositoryGetCategoryList();
        var productList = await _productRepository.repositoryGetProductList();
        emit(
          HomePageResponseState(bannerList, categoryList, productList),
        );
      },
    );
  }
}
