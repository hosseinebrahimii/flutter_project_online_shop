import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/data/datasource/banner_datasource.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/banner.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<Banners>>> repositoryGetBannerList();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Banners>>> repositoryGetBannerList() async {
    try {
      var response = await _dataSource.dataSourceGetBannerList();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      return left('Error happened in banner_repository.dart! please handle it');
    }
  }
}
