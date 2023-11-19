import 'package:dio/dio.dart';

class DioProvider {
  Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2xsZWN0aW9uSWQiOiJfcGJfdXNlcnNfYXV0aF8iLCJleHAiOjE3MDE2MTc4OTgsImlkIjoicTF5eTNtb3VvZHBodXg3IiwidHlwZSI6ImF1dGhSZWNvcmQifQ.PttMKigtZVvdYxycMv2D2IfaWBW_mP3rXnSbeEGP9Yc',
        },
      ),
    );
    return dio;
  }
}
