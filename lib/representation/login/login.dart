import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tut_app/app/app_prefs.dart';
import 'package:flutter_tut_app/representation/common/new_state_renderer/state_render_impl.dart';
import 'package:flutter_tut_app/representation/login/login_viewmodel.dart';
import 'package:flutter_tut_app/representation/resources/routes_manager.dart';
import 'package:flutter_tut_app/representation/resources/strings_manager.dart';
import 'package:flutter_tut_app/representation/resources/values_manager.dart';

import '../../app/di.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // LoginViewModel _viewModel = LoginViewModel();
  LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    _viewModel.loginSuccessStreamController.stream.listen((isLoginSuccessful) {
      print(isLoginSuccessful);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setUserLoggedIn();
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<StateFlow>(
          stream: _viewModel.outputState,
          builder: (context, snapShot) {
            return snapShot.data?.getContentWidget(context, _getContent(), () {
                  _viewModel.login();
                }) ??
                _getContent();
          }),
    );
  }

  _getContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSize.s250),
            StreamBuilder<bool>(
                stream: _viewModel.outputUserName,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.username,
                        errorText: snapshot.data ?? true
                            ? null
                            : AppStrings.usernameError,
                      ),
                    ),
                  );
                }),
            StreamBuilder<bool>(
                stream: _viewModel.outputPassword,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.password,
                        errorText: snapshot.data ?? true
                            ? null
                            : AppStrings.passwordError,
                      ),
                    ),
                  );
                }),
            SizedBox(height: AppSize.s40),
            StreamBuilder<bool>(
                stream: _viewModel.outputValidateAll,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSize.s50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p12,
                        right: AppPadding.p12,
                      ),
                      child: ElevatedButton(
                          onPressed: snapshot.data == false
                              ? null
                              : () {
                                  _viewModel.login();
                                },
                          child: Text(AppStrings.login)),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
