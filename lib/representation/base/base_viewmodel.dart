import 'dart:async';

import 'package:flutter_tut_app/representation/common/new_state_renderer/state_render_impl.dart';

abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {
  StreamController _streamController = StreamController<StateFlow>.broadcast();

  @override
  dispose() {
    _streamController.close();
  }

  @override
  Sink get inputState => _streamController.sink;

  @override
  Stream<StateFlow> get outputState =>
      _streamController.stream.map((stateFlow) => stateFlow);
}

abstract mixin class BaseViewModelInputs {
  start();
  dispose();

  Sink get inputState;
}

abstract mixin class BaseViewModelOutputs {
  Stream<StateFlow> get outputState;
}
