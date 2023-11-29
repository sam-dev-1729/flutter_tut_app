import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_tut_app/app/constants.dart';
import 'package:flutter_tut_app/data/response/response.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String? baseUrl}) = _AppServiceClient;

  @POST(Constants.loginEndpoint)
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );
}
