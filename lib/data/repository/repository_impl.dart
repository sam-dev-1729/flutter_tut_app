import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_tut_app/data/mapper/mapper.dart';
import 'package:flutter_tut_app/data/network/error_handler.dart';
import 'package:flutter_tut_app/data/network/failure.dart';
import 'package:flutter_tut_app/data/request/request.dart';
import 'package:flutter_tut_app/domain/model/model.dart';
import 'package:flutter_tut_app/domain/repository/repository.dart';

import '../network/network_info.dart';
import '../remote_data/remote_data.dart';

class RepositoryImpl implements Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        var response = await _remoteDataSource.login(loginRequest);
        if (response.status == 0) {
          return right(response.toDomain());
        } else {
          log(response.status.toString());
          return left(Failure(response.status ?? -9,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handel(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  } //admin
}
