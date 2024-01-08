import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tut_app/representation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_tut_app/representation/resources/assets_manager.dart';
import 'package:flutter_tut_app/representation/resources/color_manager.dart';
import 'package:flutter_tut_app/representation/resources/strings_manager.dart';
import 'package:flutter_tut_app/representation/resources/styles_manager.dart';
import 'package:flutter_tut_app/representation/resources/values_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../domain/model/model.dart';
import '../resources/routes_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController = PageController(initialPage: 0);
  OnboardingViewModel _viewModel = OnboardingViewModel();
  AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    _appPreferences.setOnboardingViewed();
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSlider,
        builder: (context, snapShot) {
          if (snapShot.data == null) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return _getContentWidget(snapShot.data!);
          }
        });
  }

  _getContentWidget(SliderViewObject sliderViewObject) {
    return Scaffold(
      body: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => _viewModel.changePage(index),
          itemCount: sliderViewObject.listLength,
          /*onPageChanged: (index) => setState(() {
                _currentPage = index;
              }),
          itemCount: _pages.length,*/
          itemBuilder: (_, index) {
            return _getPageWidget(sliderViewObject.sliderObject);
            //return _getPageWidget(_pages[index]);
          }),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              child: Text(AppStrings.skip),
            ),
          ),
          _getNavigatorWidget(sliderViewObject),
        ],
      ),
    );
  }

  Widget _getPageWidget(SliderObject sliderObject) {
    return Column(
      children: [
        SizedBox(height: AppSize.s100),
        Text(
          sliderObject.title,
          style: getBoldStyle(color: ColorManager.black),
        ),
        SizedBox(height: AppSize.s20),
        Text(
          sliderObject.subtitle,
          style: getBoldStyle(color: ColorManager.grey),
        ),
        SizedBox(height: AppSize.s20),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }

  Widget _getNavigatorWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: GestureDetector(
              onTap: () {
                _viewModel.toPreviousPage();
                /*
                _pageController.animateToPage(
                  _toPreviousPage(),
                  duration: Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut,
                );*/
              },
              child: SvgPicture.asset(ImageAssets.leftArrowIc),
            ),
          ),
          _getCirclesRow(sliderViewObject),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: GestureDetector(
              onTap: () {
                _viewModel.toNextPage();
                /*_pageController.animateToPage(
                  _toNextPage(),
                  duration: Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut,
                );*/
              },
              child: SvgPicture.asset(ImageAssets.rightarrowIc),
            ),
          ),
        ],
      ),
    );
  }

  _getCirclesRow(SliderViewObject sliderViewObject) {
    return Row(
      children: [
        for (int i = 0; i < sliderViewObject.listLength; i++)
          _getCircle(i, sliderViewObject.currentIndex),
      ],
    );
  }

  _getCircle(int index, int currentPage) {
    if (currentPage == index) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: SvgPicture.asset(ImageAssets.hollowCircleIc),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: SvgPicture.asset(ImageAssets.solidCircleIc),
      );
    }
  }

/*  int _toNextPage() {
    int nextPage = _currentPage + 1;
    if (nextPage == _pages.length) {
      _currentPage = 0;
    } else {
      _currentPage = nextPage;
    }
    debugPrint("$_currentPage");
    return _currentPage;
  }*/

/*  int _toPreviousPage() {
    var previousPage = _currentPage - 1;
    if (previousPage == -1) {
      _currentPage = _pages.length - 1;
    } else {
      _currentPage = previousPage;
    }
    return _currentPage;
  }*/
}
