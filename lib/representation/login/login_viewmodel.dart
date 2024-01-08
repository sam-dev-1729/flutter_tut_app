import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tut_app/representation/base/base_viewmodel.dart';
import 'package:flutter_tut_app/representation/common/freezed_common_classes.dart';

import '../../data/request/request.dart';
import '../../domain/usecase/login_usecase.dart';
import '../common/new_state_renderer/state_render_impl.dart';
import '../common/new_state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _validateAllStreamController =
      StreamController<void>.broadcast();
  StreamController loginSuccessStreamController = StreamController<bool>();
  LoginUsecase _loginUsecase;
  LoginViewModel(this._loginUsecase);

  LoginObject _loginObject = LoginObject('', '');
  // input functions

  @override
  dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _validateAllStreamController.close();
  }

  @override
  start() {
    _validate();
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputValidateAll => _validateAllStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    _loginObject = _loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  login() async {
    inputState.add(LoadingState(StateRendererType.POPUP_LOADING, null));
    (await _loginUsecase.execute(
            LoginRequest(_loginObject.userName, _loginObject.password)))
        .fold((failure) {
      // fail
      inputState
          .add(ErrorState(StateRendererType.POPUP_ERROR, failure.message));
      debugPrint(failure.message);
    }, (data) {
      // success
      inputState.add(ContentState());
      loginSuccessStreamController.add(true);
      // navigate to home
    });
  }

// output functions
  @override
  // TODO: implement outputPassword
  Stream<bool> get outputPassword => _passwordStreamController.stream
      .map((password) => _validatePassword(password));

  @override
  // TODO: implement outputUserName
  Stream<bool> get outputUserName => _userNameStreamController.stream
      .map((userName) => _validateUserName(userName));

  @override
  // TODO: implement outputValidateAll
  Stream<bool> get outputValidateAll =>
      _validateAllStreamController.stream.map((_) => _validateAll());
// private functions
  _validatePassword(String password) {
    return password.isNotEmpty;
  }

  _validateUserName(String userName) {
    return userName.isNotEmpty;
  }

  bool _validateAll() {
    return _validatePassword(_loginObject.password) &&
        _validateUserName(_loginObject.userName);
  }

  void _validate() {
    inputValidateAll.add(null);
  }
}

abstract mixin class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputValidateAll;
}

abstract mixin class LoginViewModelOutputs {
  Stream<bool> get outputUserName;
  Stream<bool> get outputPassword;
  Stream<bool> get outputValidateAll;
}
