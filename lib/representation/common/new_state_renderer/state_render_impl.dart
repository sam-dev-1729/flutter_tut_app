import 'package:flutter/material.dart';
import 'package:flutter_tut_app/representation/common/new_state_renderer/state_renderer.dart';
import 'package:flutter_tut_app/representation/resources/strings_manager.dart';

import '../../../app/extensions.dart';

abstract class StateFlow {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends StateFlow {
  StateRendererType stateRendererType;
  String message;
  LoadingState(this.stateRendererType, String? message)
      : message = message ?? AppStrings.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends StateFlow {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends StateFlow {
  ContentState();
  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.FULLSCREEN_CONTENT;
}

class EmptyState extends StateFlow {
  String message;
  EmptyState(String? message) : message = message ?? EMPTY;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.FULLSCREEN_EMPTY;
}

extension StateFlowExtension on StateFlow {
  Widget getContentWidget(BuildContext context, Widget defaultContentWidget,
      Function retryFunction) {
    print(this.runtimeType);
    switch (this.runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.POPUP_LOADING) {
          _getDialog(context, getStateRendererType(), getMessage());
          return defaultContentWidget;
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(), message: getMessage());
        }
      case ErrorState:
        _dismissedDialog(context);
        if (getStateRendererType() == StateRendererType.POPUP_ERROR) {
          _getDialog(context, getStateRendererType(), getMessage());
          return defaultContentWidget;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryFunction: retryFunction,
          );
        }
      case EmptyState:
        return Container();
      case ContentState:
        _dismissedDialog(context);
        return defaultContentWidget;

      default:
        return defaultContentWidget;
    }
  }

  _dismissedDialog(BuildContext context) {
    if (_isCurrentShowingDialog(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isCurrentShowingDialog(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  _getDialog(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (context) {
            return StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryFunction: () {},
            );
          });
    });
  }
}
