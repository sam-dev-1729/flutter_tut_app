abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {}

abstract class BaseViewModelInputs {
  void dispose();
  void start();
}

abstract class BaseViewModelOutputs {}
