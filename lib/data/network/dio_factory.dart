import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tut_app/app/app_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/constants.dart';

const CONTENT_TYPE = "content-type";
const APPLICATION_JSON = "application/json";
const ACCEPT = "accept";
const LANGUAGE = "language";
const AUTHORISED = "authorised";

class DioFactory {
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();
    var timeout = 60 * 1000;
    var headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      LANGUAGE: language,
      AUTHORISED: Constants.token,
    };

    dio.options = BaseOptions(
      headers: headers,
      sendTimeout: Duration(milliseconds: timeout),
      receiveTimeout: Duration(milliseconds: timeout),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        responseHeader: true,
        responseBody: true,
        requestBody: true,
      ));
    } else {
      debugPrint('release mode has no log');
    }
    return dio;
  }
}

class DioFactory2 {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    var timeout = 60 * 1000;
    var headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
    };

    dio.options = BaseOptions(
      headers: headers,
      sendTimeout: Duration(milliseconds: timeout),
      receiveTimeout: Duration(milliseconds: timeout),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        responseHeader: true,
        responseBody: true,
        requestBody: true,
      ));
    } else {
      debugPrint('release mode has no log');
    }
    return dio;
  }
}
