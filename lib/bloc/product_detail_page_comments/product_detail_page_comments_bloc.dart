import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_event.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_state.dart';
import 'package:flutter_project_online_shop/data/repository/comment_repository.dart';

class ProductDetailPageCommentsBloc extends Bloc<ProductDetailPageCommentsEvent, ProductDetailPageCommentsState> {
  final ICommentRepository _repository;

  ProductDetailPageCommentsBloc(this._repository) : super(ProductDetailPageCommentsLoadingState()) {
    on<ProductDetailPageCommentsRequestCommentsEvent>(
      (event, emit) async {
        emit(ProductDetailPageCommentsLoadingState());
        var commentListEither = await _repository.repositoryGetCommentList(event.product);
        emit(ProductDetailPageCommentsResponseCommentsState(commentListEither));
      },
    );
    on<ProductDetailPageCommentsRequestPostCommentEvent>(
      (event, emit) async {
        emit(ProductDetailPageCommentsLoadingState());

        await _repository.repositoryPostComment(
          event.product,
          event.commentText,
        );
        var commentListEither = await _repository.repositoryGetCommentList(event.product);
        emit(ProductDetailPageCommentsResponseCommentsState(commentListEither));
      },
    );
  }
}
