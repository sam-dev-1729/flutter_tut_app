import 'package:dartz/dartz.dart';
import 'package:flutter_tut_app/data/network/failure.dart';
import 'package:flutter_tut_app/data/request/request.dart';
import 'package:flutter_tut_app/domain/model/model.dart';
import 'package:flutter_tut_app/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class LoginUsecase extends BaseUsecase<Authentication, LoginRequest> {
  Repository _repository;
  LoginUsecase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginRequest input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}
