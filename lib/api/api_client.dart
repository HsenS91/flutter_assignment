import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_work/api/url.dart';
import 'package:my_work/model/base_response/base_response.dart';
import 'package:my_work/model/login_model/login_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: Urls.BASE_URL)
abstract class ApiClient<T> {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient<T>;

  @POST(Urls.LOGIN)
  Future<HttpResponse> login(@Body() Map<String, dynamic> data);

  @POST(Urls.RESET_PASSWORD_FORM)
  Future<BaseResponse> resetPasswordForm(@Body() Map<String, dynamic> data);

  @POST(Urls.RESET_PASSWORD)
  Future<BaseResponse> resetPassword(@Body() Map<String, dynamic> data);

  @GET(Urls.GET_WORK_BY_ID)
  Future<BaseResponse> getWorkById(@Query('work-id') int? id);

  @POST(Urls.CREATE_WORK)
  Future<BaseResponse> createWork(
      @Part(value: 'name', ) String name,
      @Part(value: 'path', contentType: 'image/*') File path
  );

  @GET(Urls.GET_WORK_BY_USER_ID)
  Future<BaseResponse> getWorkByUserId(@Query('user-id') int? id);

  @POST(Urls.UPDATE_WORK)
  Future<BaseResponse> updateWork(@Body() Map<String, dynamic> data);

  @DELETE(Urls.DELETE_WORK)
  Future<BaseResponse> deleteWork(@Body() Map<String, dynamic> data);
}