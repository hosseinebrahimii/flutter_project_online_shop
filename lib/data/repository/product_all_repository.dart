import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/data/datasource/product_all_datasource.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/models/product_details.dart';
import 'package:flutter_project_online_shop/models/product_properties.dart';
import 'package:flutter_project_online_shop/models/product_variant_type.dart';
import 'package:flutter_project_online_shop/models/product_variants.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class IProductAllRepository {
  Future<Either<String, List<Product>>> repositoryGetProductList();
  Future<Either<String, List<ProductDetail>>> repositoryGetProductDetailList();
  Future<Either<String, List<ProductVariantType>>> repositoryGetProductVariantTypeList();
  Future<Either<String, List<ProductVariants>>> repositoryGetProductVariantsList();
  Future<Either<String, List<ProductProperties>>> repositoryGetProductPropertiesList();
}

class ProductAllRepository extends IProductAllRepository {
  final IProductAllDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Product>>> repositoryGetProductList() async {
    try {
      var response = await _dataSource.dataSourceGetProductList();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Either<String, List<ProductDetail>>> repositoryGetProductDetailList() async {
    try {
      var response = await _dataSource.dataSourceGetProductDetailList();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Either<String, List<ProductVariants>>> repositoryGetProductVariantsList() async {
    try {
      var response = await _dataSource.dataSourceGetProductVariantsList();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Either<String, List<ProductVariantType>>> repositoryGetProductVariantTypeList() async {
    try {
      var response = await _dataSource.dataSourceGetProductVariantTypeList();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Either<String, List<ProductProperties>>> repositoryGetProductPropertiesList() async {
    try {
      var response = await _dataSource.dataSourceGetProductPropertiesList();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      rethrow;
    }
  }
}
