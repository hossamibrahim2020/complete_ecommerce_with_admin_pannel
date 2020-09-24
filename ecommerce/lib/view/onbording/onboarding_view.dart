import '../auth/auth_view.dart';
import 'animated_container_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../shared/constants.dart';
import 'screens_array.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController;
  final ScreensArray _screensArray = ScreensArray();
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _button = Provider.of<AnimatedContainerProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context, _button),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _bottom(context, _button),
    );
  }

  Widget _body(BuildContext context, AnimatedContainerProvider value) {
    return Stack(
      children: <Widget>[
        PageView(
          controller: _pageController,
          children: _screensArray.screenArray,
          onPageChanged: (int index) {
            if (index == 2) {
              value.runButton();
            } else {
              value.disposeButton();
            }
          },
        ),
        Positioned(
          left: 20,
          top: MediaQuery.of(context).size.height * .35,
          child: Container(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              axisDirection: Axis.vertical,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.teal,
                dotColor: Colors.blueGrey.shade300.withOpacity(.5),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottom(BuildContext context, AnimatedContainerProvider value) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setBool('seeOnboarding', true);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AuthView(),
          ),
        );
      },
      child: AnimatedContainer(
        curve: Curves.bounceInOut,
        duration: Duration(milliseconds: 500),
        height: value.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.teal.shade300,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            'get start'.toUpperCase(),
            style: whiteTextStyle.copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
