import 'package:flutter_tut_app/app/functions.dart';
import 'package:flutter_tut_app/data/network/app_api.dart';
import 'package:flutter_tut_app/data/request/request.dart';
import 'package:flutter_tut_app/domain/model/model.dart';

import '../response/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    DeviceInfo _deviceInfo = await getDeviceInfo();

    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      "1",
      "1",
      /* _deviceInfo.identifier,
      _deviceInfo.version,*/
    );
  }
}
