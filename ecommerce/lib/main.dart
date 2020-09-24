import 'view/onbording/animated_container_provider.dart';
import 'view/onbording/onboarding_view.dart';
import 'models/cart_model_database.dart';
import 'view/cart/count_in_moor_provider.dart';
import 'models/is_loding_provider.dart';
import 'view/home/firebase_stream_viewmodel.dart';
import 'view/navigation/bottom_navigation_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/shared/theme.dart';
import 'view/auth/auth_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'view/detail/count_of_it_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool _seeOnboarding = _prefs.getBool('seeOnboarding');
  bool _seen = _prefs.getBool('seen');
  Widget screen = AuthView();
  if (_seeOnboarding == null || _seeOnboarding == false) {
    screen = OnBoardingView();
  } else {
    if (_seen == true) {
      screen = BottomNavigationView();
    } else if (_seen == false || _seen == null) {
      screen = AuthView();
    }
  }

  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {
  final Widget home;
  const MyApp(this.home);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IsLoding>(
          create: (BuildContext context) {
            return IsLoding();
          },
        ),
        ChangeNotifierProvider<CountOfItProvider>(
          create: (BuildContext context) {
            return CountOfItProvider();
          },
        ),
        ChangeNotifierProvider<CountInMoorProvider>(
          create: (BuildContext context) {
            return CountInMoorProvider();
          },
        ),
        ChangeNotifierProvider<AnimatedContainerProvider>(
          create: (BuildContext context) {
            return AnimatedContainerProvider();
          },
        ),

        /// Singleton Design pattern
        Provider<CartDatabase>(
          create: (BuildContext context) => CartDatabase(),
          dispose: (BuildContext context, CartDatabase db) => db.close(),
        ),
        Provider<FirebaseStreamViewmodel>(
          create: (_) => FirebaseStreamViewmodel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Shop',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: home,
      ),
    );
  }
}
