import 'package:flutter/material.dart';
import 'package:flutter_tut_app/representation/resources/assets_manager.dart';
import 'package:flutter_tut_app/representation/resources/color_manager.dart';
import 'package:flutter_tut_app/representation/resources/font_manager.dart';
import 'package:flutter_tut_app/representation/resources/strings_manager.dart';
import 'package:flutter_tut_app/representation/resources/styles_manager.dart';
import 'package:flutter_tut_app/representation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  //
  FULLSCREEN_LOADING,
  FULLSCREEN_ERROR,
  FULLSCREEN_CONTENT,
  FULLSCREEN_EMPTY,
  //
  POPUP_LOADING,
  POPUP_ERROR,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  Function? retryFunction;
  StateRenderer(
      {super.key,
      required this.stateRendererType,
      String? message,
      this.retryFunction})
      : message = message ?? AppStrings.loading;

  @override
  Widget build(BuildContext context) {
    return _getContentWidget(context);
  }

  _getContentWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.FULLSCREEN_LOADING:
        return _getColumnItems(
            [_getAnimatedImage(JsonAssets.loading), _getText(message)]);
      case StateRendererType.FULLSCREEN_ERROR:
        return _getColumnItems([
          _getAnimatedImage(JsonAssets.error),
          _getText(message),
          _getRetryButton(context)
        ]);
      case StateRendererType.FULLSCREEN_CONTENT:
        return Container();
      case StateRendererType.FULLSCREEN_EMPTY:
        return _getColumnItems([
          _getAnimatedImage(JsonAssets.empty),
          _getText(message),
        ]);
      case StateRendererType.POPUP_LOADING:
        return _getDialog([
          _getAnimatedImage(JsonAssets.loading),
          _getText(message),
        ]);
      case StateRendererType.POPUP_ERROR:
        return _getDialog([
          _getAnimatedImage(JsonAssets.error),
          _getText(message),
          _getRetryButton(context)
        ]);
    }
  }

  _getColumnItems(List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  _getAnimatedImage(String scr) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p12),
      child: SizedBox(
        height: AppSize.s200,
        width: AppSize.s200,
        child: Lottie.asset(scr),
      ),
    );
  }

  _getText(String text) {
    return Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style:
              getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ));
  }

  _getRetryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: SizedBox(
        height: AppSize.s50,
        width: AppSize.s180,
        child: ElevatedButton(
          onPressed: () {
            if (stateRendererType == StateRendererType.FULLSCREEN_ERROR) {
              retryFunction?.call();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(AppStrings.retry_again),
        ),
      ),
    );
  }

  _getDialog(List<Widget> children) {
    return Dialog(
      elevation: AppSize.s1_5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(AppSize.s0, AppSize.s12),
            ),
          ],
        ),
        child: _getDialogContent(children),
      ),
    );
  }

  _getDialogContent(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
