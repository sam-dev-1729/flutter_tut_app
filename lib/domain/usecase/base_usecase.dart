import 'package:dartz/dartz.dart';
import 'package:flutter_tut_app/data/network/failure.dart';

abstract class BaseUsecase<Out, In> {
  Future<Either<Failure, Out>> execute(In input);
}
