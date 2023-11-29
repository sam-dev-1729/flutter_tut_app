import 'dart:convert';

import 'package:dio/dio.dart';

import 'data/response/response.dart';

void main() {
  _get();
}

_get() async {
/*
  Dio dio = Dio();
  const url = "https://koze0.wiremockapi.cloud/login";
  final response = await dio.post(url, data: {
    'email': "admin",
    'password': 'admin',
    'imei': "1",
    "deviceType": "1"
  });
  var a = AuthenticationResponse.fromJson(json.decode(response.toString()));
  print("${a.customer?.name}");
  */
  /*SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  AppPreferences appPreferences = AppPreferences(sharedPreferences);
  DioFactory dioFactory = DioFactory(appPreferences)
  DioFactory2 dioFactory = DioFactory2();;*/

  /*RemoteDataSource remoteDataSource = RemoteDataSourceImpl(appServiceClient);
  InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  NetworkInfo networkInfo = NetworkInfoImpl(internetConnectionChecker);
  Repository repository = RepositoryImpl(remoteDataSource, networkInfo);*/
  //var b = await repository.login(LoginRequest("admin", "admin"));
  var b = await login();
  print(b.customer?.name);
}

Future<AuthenticationResponse> login() async {
  final Dio _dio = Dio();
  const url = "https://koze0.wiremockapi.cloud";

  final _data = {
    'email': "admin",
    'password': "admin",
    'imei': "1",
    'deviceType': "1",
  };
  final _result = await _dio
      .fetch(_setStreamType<AuthenticationResponse>(Options(method: 'POST')
          .compose(
            _dio.options,
            '/login',
            data: _data,
          )
          .copyWith(baseUrl: url)));
  final value = AuthenticationResponse.fromJson(json.decode(_result.data));
  return value;
}

RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
  if (T != dynamic &&
      !(requestOptions.responseType == ResponseType.bytes ||
          requestOptions.responseType == ResponseType.stream)) {
    if (T == String) {
      requestOptions.responseType = ResponseType.plain;
    } else {
      requestOptions.responseType = ResponseType.json;
    }
  }
  return requestOptions;
}

String _combineBaseUrls(
  String dioBaseUrl,
  String? baseUrl,
) {
  if (baseUrl == null || baseUrl.trim().isEmpty) {
    return dioBaseUrl;
  }

  final url = Uri.parse(baseUrl);

  if (url.isAbsolute) {
    return url.toString();
  }

  return Uri.parse(dioBaseUrl).resolveUri(url).toString();
}
