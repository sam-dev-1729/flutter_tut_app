/*
import 'package:flutter/material.dart';
import 'package:flutter_tut_app/app/extensions.dart';
import 'package:flutter_tut_app/representation/common/state_renderer/state_renderer.dart';
import 'package:flutter_tut_app/representation/resources/strings_manager.dart';

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
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_STATE;
}

class EmptyState extends StateFlow {
  String message;
  EmptyState(String? message) : message = message ?? EMPTY;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.EMPTY_STATE;
}

extension StateFlowExtension on StateFlow {
  Widget getContentWidget(
      BuildContext context, getContent, Function retryFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
          return _getDialog(context, getStateRendererType(), getMessage());
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryFunction: () {},
          );
        }
      case ErrorState:
        _dismissed(context);
        if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
          return _getDialog(context, getStateRendererType(), getMessage());
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryFunction: retryFunction);
        }
      case ContentState:
        _dismissed(context);
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          retryFunction: () {},
        );
      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(), retryFunction: () {});
      default:
        return getContent;
    }
  }

  _dismissed(BuildContext context) {
    if (_isCurrent(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  bool _isCurrent(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  _getDialog(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryFunction: () {
                // Navigator.of(context).pop();
              }));
    });
  }
}
*/
