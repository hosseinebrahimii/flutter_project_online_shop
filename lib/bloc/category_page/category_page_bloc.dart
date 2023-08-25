import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_event.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_state.dart';
import 'package:flutter_project_online_shop/data/repository/category_repository.dart';

class CategoryPageBloc extends Bloc<CategoryPageEvent, CategoryPageState> {
  final ICategoryRepository _categoryRepository;
  CategoryPageBloc(this._categoryRepository) : super(CategoryPageInitState()) {
    on<CategoryPageRequestEvent>(
      (event, emit) async {
        emit(CategoryPageLoadingState());
        var either = await _categoryRepository.repositoryGetCategoryList();
        emit(CategoryPageResponseState(either));
      },
    );
  }
}
