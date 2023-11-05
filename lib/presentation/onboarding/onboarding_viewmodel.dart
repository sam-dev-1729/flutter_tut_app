import 'dart:async';

import '../../domin/models.dart';
import '../base/baseviewmodel.dart';
import '../resources/asset_manager.dart';
import '../resources/string_manager.dart';

class OnboardingViewModel extends BaseViewModel
    implements OnboardingViewModelInputs, OnboardingViewModelOutputs {
  int _currentIndex = 0;
  late final List<SliderObject> _list;

  late StreamController _streamController =
      StreamController<SliderViewObject>();

  // input function
  @override
  void start() {
    _list = _getSliderList();
    sendDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  changePage(int index) {
    _currentIndex = index;
    sendDataToView();
  }

  @override
  goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex == _list.length - 1) {
      _currentIndex = 0;
    }
    sendDataToView();
  }

  @override
  goPrevious() {
    int previousIndex = --_currentIndex;

    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    sendDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

// output function
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private function
  List<SliderObject> _getSliderList() {
    return [
      SliderObject(
        AppStrings.title1,
        AppStrings.subtitle1,
        ImageAsset.onboardingLogo1,
      ),
      SliderObject(
        AppStrings.title2,
        AppStrings.subtitle2,
        ImageAsset.onboardingLogo2,
      ),
      SliderObject(
        AppStrings.title3,
        AppStrings.subtitle3,
        ImageAsset.onboardingLogo3,
      ),
      SliderObject(
        AppStrings.title4,
        AppStrings.subtitle4,
        ImageAsset.onboardingLogo4,
      ),
    ];
  }

  sendDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnboardingViewModelInputs {
  goNext();
  goPrevious();
  changePage(int index);
  Sink get inputSliderViewObject;
}

abstract class OnboardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int listLength;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.listLength, this.currentIndex);
}
