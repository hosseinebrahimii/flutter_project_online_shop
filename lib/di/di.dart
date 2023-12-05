import 'package:dio/dio.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/home_page/home_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page/product_detail_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/product_detail_page_comments/product_detail_page_comments_bloc.dart';
import 'package:flutter_project_online_shop/bloc/purchase_cart_page/purchase_cart_page_bloc.dart';
import 'package:flutter_project_online_shop/data/datasource/authentication_datasource.dart';
import 'package:flutter_project_online_shop/data/datasource/banner_datasource.dart';
import 'package:flutter_project_online_shop/data/datasource/category_datasource.dart';
import 'package:flutter_project_online_shop/data/datasource/comment_datasource.dart';
import 'package:flutter_project_online_shop/data/datasource/product_all_datasource.dart';
import 'package:flutter_project_online_shop/data/datasource/purchase_cart_datasource.dart';
import 'package:flutter_project_online_shop/data/repository/authentication_repository.dart';
import 'package:flutter_project_online_shop/data/repository/banner_repository.dart';
import 'package:flutter_project_online_shop/data/repository/category_repository.dart';
import 'package:flutter_project_online_shop/data/repository/comment_repository.dart';
import 'package:flutter_project_online_shop/data/repository/product_all_repository.dart';
import 'package:flutter_project_online_shop/data/repository/purchase_cart_repository.dart';
import 'package:flutter_project_online_shop/util/dio_provider.dart';
import 'package:flutter_project_online_shop/util/payment_handler.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarinpal/zarinpal.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  //util - paymentHandler:
  locator.registerFactory<PaymentRequest>(() => PaymentRequest());

  //util - authManager:
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  //datasource folder:
  locator.registerSingleton<Dio>(
    DioProvider.createDioWithHeader(),
  );

  //repository folder:
  locator.registerFactory<IAuthenticatorDataSource>(() => AuthenticationDataSource());
  locator.registerFactory<ICategoryDataSource>(() => CategoryDataSource());
  locator.registerFactory<IBannerDataSource>(() => BannerDataSource());
  locator.registerFactory<IProductAllDataSource>(() => ProductAllDataSource());
  locator.registerFactory<IPurchaseCartDataSource>(() => PurchaseCartLocalDataSource());
  locator.registerFactory<ICommentDataSource>(() => CommentDataSource());

  //authenticationBloc:
  locator.registerFactory<IAuthenticationRepository>(() => AuthenticationRepository());

  //category_page_bloc & home_page_bloc:
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());

  //home_page_bloc:
  locator.registerFactory<IBannerRepository>(() => BannerRepository());

  //product_detail_page_bloc.dart:
  locator.registerFactory<IProductAllRepository>(() => ProductAllRepository());

  //product_detail_page_comments_bloc.dart:
  locator.registerFactory<ICommentRepository>(() => CommentRepository());

  //puchase_cart_page_bloc.dart:
  locator.registerFactory<IPurchaseCartRepository>(() => PurchaseCartRepository());
  locator.registerSingleton<PaymentHandler>(ZarinPalPaymentHandler(locator.get()));

  //main:
  locator.registerSingleton<AuthenticationBloc>(AuthenticationBloc(locator.get()));
  locator.registerSingleton<CategoryPageBloc>(CategoryPageBloc(locator.get()));
  locator.registerSingleton<HomePageBloc>(HomePageBloc(locator.get(), locator.get(), locator.get()));
  locator.registerSingleton<ProductDetailPageBloc>(ProductDetailPageBloc(locator.get(), locator.get()));
  locator.registerSingleton<PurchaseCartPageBloc>(PurchaseCartPageBloc(locator.get(), locator.get()));
  locator.registerSingleton<ProductDetailPageCommentsBloc>(ProductDetailPageCommentsBloc(locator.get()));
}
