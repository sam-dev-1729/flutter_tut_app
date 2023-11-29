import 'package:flutter_tut_app/app/extensions.dart';
import 'package:flutter_tut_app/data/response/response.dart';
import 'package:flutter_tut_app/domain/model/model.dart';

extension ContentResponseMapper on ContentResponse? {
  Content toDomain() {
    return Content(
      this?.phone?.orEmpty() ?? EMPTY,
      this?.email?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.countOfNotification?.orZero() ?? ZERO,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer?.toDomain(),
      this?.content?.toDomain(),
    );
  }
}
