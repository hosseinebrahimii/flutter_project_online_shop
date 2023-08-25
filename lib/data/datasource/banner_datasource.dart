import 'package:dio/dio.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/banner.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class IBannerDataSource {
  Future<List<Banners>> dataSourceGetBannerList();
}

class BannerDataSource extends IBannerDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Banners>> dataSourceGetBannerList() async {
    try {
      var response = await _dio.get('/collections/banner/records');
      List<Banners> bannerList =
          response.data['items'].map<Banners>((jsonObject) => Banners.getFromJsonMapObject(jsonObject)).toList();
      return bannerList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      throw ApiException(1, 'something unhandled happened, check banner_datasource.dart');
    }
  }
}
