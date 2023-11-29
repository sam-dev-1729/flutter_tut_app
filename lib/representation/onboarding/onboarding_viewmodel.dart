import 'dart:async';

import 'package:flutter_tut_app/representation/base/base_viewmodel.dart';

import '../../domain/model/model.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModeOutputs {
  StreamController _sliderStreamController =
      StreamController<SliderViewObject>();
  int _currentPage = 0;
  late List<SliderObject> _pages = _getPages();

// input functions
  @override
  dispose() {
    _sliderStreamController.close();
  }

  @override
  start() {
    _pages = _getPages();
    sendDataToView();
  }

  @override
  changePage(int index) {
    _currentPage = index;
    sendDataToView();
  }

  @override
  Sink get inputSlider => _sliderStreamController.sink;

  @override
  toNextPage() {
    int nextPage = _currentPage + 1;
    if (nextPage == _pages.length) {
      _currentPage = 0;
    } else {
      _currentPage = nextPage;
    }
    sendDataToView();
  }

  @override
  toPreviousPage() {
    var previousPage = _currentPage - 1;
    if (previousPage == -1) {
      _currentPage = _pages.length - 1;
    } else {
      _currentPage = previousPage;
    }
    sendDataToView();
  }

  // output functions
  @override
  Stream<SliderViewObject> get outputSlider => _sliderStreamController.stream
      .map((sliderViewObject) => sliderViewObject);

  // private function
  _getPages() => [
        SliderObject(
          AppStrings.onBoardingTitle1,
          AppStrings.onBoardingSubTitle1,
          ImageAssets.onboardingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2,
          AppStrings.onBoardingSubTitle2,
          ImageAssets.onboardingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3,
          AppStrings.onBoardingSubTitle3,
          ImageAssets.onboardingLogo3,
        ),
        SliderObject(
          AppStrings.onBoardingTitle4,
          AppStrings.onBoardingSubTitle4,
          ImageAssets.onboardingLogo4,
        ),
      ];

  sendDataToView() {
    inputSlider.add(SliderViewObject(
      _pages[_currentPage],
      _currentPage,
      _pages.length,
    ));
  }
}

abstract mixin class OnboardingViewModelInputs {
  toNextPage();
  toPreviousPage();
  changePage(int index);

  Sink get inputSlider;
}

abstract mixin class OnboardingViewModeOutputs {
  Stream<SliderViewObject> get outputSlider;
}

class SliderViewObject {
  int currentIndex;
  int listLength;
  SliderObject sliderObject;

  SliderViewObject(this.sliderObject, this.currentIndex, this.listLength);
}
