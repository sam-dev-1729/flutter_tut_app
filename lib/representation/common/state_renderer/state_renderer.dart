/*
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_tut_app/representation/resources/assets_manager.dart';
import 'package:flutter_tut_app/representation/resources/color_manager.dart';
import 'package:flutter_tut_app/representation/resources/font_manager.dart';
import 'package:flutter_tut_app/representation/resources/strings_manager.dart';
import 'package:flutter_tut_app/representation/resources/styles_manager.dart';
import 'package:flutter_tut_app/representation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // fullscreen state
  FULLSCREEN_LOADING_STATE,
  FULLSCREEN_ERROR_STATE,
  CONTENT_STATE,
  EMPTY_STATE,
  // popup states
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  Function? retryFunction;

  StateRenderer(
      {super.key,
      required this.stateRendererType,
      String? message,
      required this.retryFunction})
      : message = message ?? AppStrings.loading;

  @override
  Widget build(BuildContext context) {
    return _getWidget(stateRendererType);
  }

  Widget _getWidget(StateRendererType stateRendererType) {
    switch (stateRendererType) {
      case StateRendererType.FULLSCREEN_LOADING_STATE:
        return _getColumnItems([
          _getJsonImage(JsonAssets.loading),
          _getText(message),
        ]);
      case StateRendererType.FULLSCREEN_ERROR_STATE:
        return _getColumnItems([
          _getJsonImage(JsonAssets.error),
          _getText(message),
          _getRetryButton(),
        ]);
      case StateRendererType.CONTENT_STATE:
        return Container();
      case StateRendererType.EMPTY_STATE:
        return _getColumnItems([
          _getJsonImage(JsonAssets.empty),
          _getText(message),
        ]);
      case StateRendererType.POPUP_LOADING_STATE:
        return _getDialog([
          _getJsonImage(JsonAssets.loading),
          _getText(message),
        ]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getDialog([
          _getJsonImage(JsonAssets.error),
          _getText(message),
          _getRetryButton(),
        ]);
      default:
        return Container();
    }
  }

  Widget _getDialog(List<Widget> children) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        elevation: AppSize.s1_5,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s12),
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ],
          ),
          child: _getDialogContent(children),
        ));
  }

  _getDialogContent(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  _getJsonImage(String jsonPath) {
    return SizedBox(
        height: AppSize.s180,
        width: AppSize.s180,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Lottie.asset(jsonPath),
        ));
  }

  _getRetryButton() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: SizedBox(
        width: AppSize.s180,
        height: AppSize.s50,
        child: ElevatedButton(
          onPressed: () {
            retryFunction?.call();
          },
          child: Text(AppStrings.retry_again),
        ),
      ),
    );
  }

  _getText(String message) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Text(
        message,
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s16,
        ),
      ),
    );
  }

  _getColumnItems(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
*/
