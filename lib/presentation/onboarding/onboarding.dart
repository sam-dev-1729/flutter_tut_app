import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tut_app/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_tut_app/presentation/resources/asset_manager.dart';
import 'package:flutter_tut_app/presentation/resources/color_manager.dart';
import 'package:flutter_tut_app/presentation/resources/route_manager.dart';
import 'package:flutter_tut_app/presentation/resources/string_manager.dart';
import 'package:flutter_tut_app/presentation/resources/values_manager.dart';

import '../../domin/models.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController = PageController(initialPage: 0);

  OnboardingViewModel onboardingViewModel = OnboardingViewModel();
  @override
  void initState() {
    onboardingViewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    onboardingViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject?>(
        stream: onboardingViewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => onboardingViewModel.changePage(index),
          itemCount: sliderViewObject.listLength,
          itemBuilder: (context, index) {
            return OnboardingPage(sliderViewObject.sliderObject);
          },
        ),
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginRoute);
                },
                child: Text(AppStrings.skip),
              ),
            ),
            Container(
              height: 50,
              color: ColorManager.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: SvgPicture.asset(ImageAsset.leftArrow),
                    ),
                    onTap: () {
                      onboardingViewModel.goPrevious();
                    },
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < sliderViewObject.listLength; i++)
                        Padding(
                          padding: EdgeInsets.all(AppPadding.p8),
                          child: _getCircleIndicator(
                              i, sliderViewObject.currentIndex),
                        ),
                    ],
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: SvgPicture.asset(ImageAsset.rightArrow),
                    ),
                    onTap: () {
                      onboardingViewModel.goNext();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  _getCircleIndicator(int index, int currentIndex) {
    if (index != currentIndex) {
      return SvgPicture.asset(ImageAsset.hollowCircle);
    } else {
      return SvgPicture.asset(ImageAsset.solidCircle);
    }
  }

  // _goToNextPage() {
  //   int _nextIndex = _currentIndex++;
  //   if (_nextIndex == _list.length - 1) {
  //     _currentIndex = 0;
  //   }
  //   return _currentIndex;
  // }
  //
  // _goToPreviousPage() {
  //   int _previousIndex = _currentIndex--;
  //   if (_previousIndex == -1) {
  //     _currentIndex = _list.length - 1;
  //   }
  //   return _currentIndex;
  // }
}

class OnboardingPage extends StatelessWidget {
  SliderObject sliderObject;
  OnboardingPage(this.sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sliderObject.title),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sliderObject.subtitle),
        ),
        SizedBox(height: 50),
        SvgPicture.asset(sliderObject.image),
        SizedBox(height: 50),
      ],
    );
  }
}
