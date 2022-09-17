import 'package:dio/dio.dart';
import 'package:my_work/api/api_client.dart';

class ApiProvider {
  static final ApiProvider _singleton = ApiProvider._internal();
  final Dio dio = Dio();

  static String? authToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXBpZGV2LnRhYmtoYS5vbmxpbmUvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2NjM0MTk3MTQsImV4cCI6MTY2MzQ0MTMxNCwibmJmIjoxNjYzNDE5NzE0LCJqdGkiOiJEV2dwQmh2Q28zazR4aWZCIiwic3ViIjoiMiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.NsUuEhwArfVkxzcVUJbcxBISK_OoiN9OgFyLxVo0EkA';

  factory ApiProvider() {
    return _singleton;
  }

  ApiProvider._internal();

  ApiClient getClient() {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    dio.options.headers['Authorization'] = 'Bearer $authToken';
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return status! < 500;
    };
    return ApiClient(dio);
  }
}