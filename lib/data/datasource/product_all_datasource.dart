import 'package:dio/dio.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/models/product_details.dart';
import 'package:flutter_project_online_shop/models/product_properties.dart';
import 'package:flutter_project_online_shop/models/product_variant_type.dart';
import 'package:flutter_project_online_shop/models/product_variants.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class IProductAllDataSource {
  Future<List<Product>> dataSourceGetProductList();
  Future<List<ProductDetail>> dataSourceGetProductDetailList();
  Future<List<ProductVariantType>> dataSourceGetProductVariantTypeList();
  Future<List<ProductVariants>> dataSourceGetProductVariantsList();
  Future<List<ProductProperties>> dataSourceGetProductPropertiesList();
}

class ProductAllDataSource extends IProductAllDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> dataSourceGetProductList() async {
    try {
      var response = await _dio.get('/collections/products/records');
      List<Product> productList =
          response.data['items'].map<Product>((jsonObject) => Product.getFromJsonMapObject(jsonObject)).toList();
      return productList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<List<ProductDetail>> dataSourceGetProductDetailList() async {
    try {
      var response = await _dio.get('/collections/gallery/records');
      List<ProductDetail> productDetailList = response.data['items']
          .map<ProductDetail>((jsonObject) => ProductDetail.getFromJsonMapObject(jsonObject))
          .toList();
      return productDetailList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<List<ProductVariants>> dataSourceGetProductVariantsList() async {
    try {
      var response = await _dio.get('/collections/variants/records');
      List<ProductVariants> productVariantsList = response.data['items']
          .map<ProductVariants>((jsonObject) => ProductVariants.getFromJsonMapObject(jsonObject))
          .toList();
      return productVariantsList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<List<ProductVariantType>> dataSourceGetProductVariantTypeList() async {
    try {
      var response = await _dio.get('/collections/variants_type/records');
      List<ProductVariantType> productVariantTypeList = response.data['items']
          .map<ProductVariantType>((jsonObject) => ProductVariantType.getFromJsonMapObject(jsonObject))
          .toList();
      return productVariantTypeList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<List<ProductProperties>> dataSourceGetProductPropertiesList() async {
    try {
      var response = await _dio.get('/collections/properties/records');
      List<ProductProperties> productPropertiesList = response.data['items']
          .map<ProductProperties>((jsonObject) => ProductProperties.getFromJsonMapObject(jsonObject))
          .toList();
      return productPropertiesList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      rethrow;
    }
  }
}
