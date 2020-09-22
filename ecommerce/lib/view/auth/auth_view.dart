import 'package:animated_text_kit/animated_text_kit.dart';
import '../../view/signin/signin_view.dart';
import '../shared/widget/custom_button.dart';
import '../shared/widget/reusable_backgraound_image.dart';
import 'package:flutter/material.dart';
import '../signup/signup_view.dart';

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final int _begin = (MediaQuery.of(context).size.height * 0.4).toInt();
    return ReusbableBackGraoundImage(
      TweenAnimationBuilder(
        curve: Curves.ease,
        duration: Duration(seconds: 2),
        tween: IntTween(begin: _begin, end: 30),
        builder: (BuildContext context, int value, Widget child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(width: 20.0, height: 100.0),
                  Text(
                    'Be',
                    style: TextStyle(
                      fontSize: 43.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'hind',
                    ),
                  ),
                  SizedBox(width: 20.0, height: 100.0),
                  RotateAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    text: ['FASHON', 'AWESOME', 'DIFFERENT'],
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'hind',
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              CustomRadiusButton(
                onpress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignInView(),
                    ),
                  );
                },
                label: 'Sigin',
                color: Theme.of(context).primaryColor,
              ),
              CustomRadiusButton(
                onpress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignUPView(),
                    ),
                  );
                },
                label: 'Regester',
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: value.toDouble(),
              ),
            ],
          );
        },
      ),
    );
  }
}
