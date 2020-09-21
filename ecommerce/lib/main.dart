import 'models/is_loding_provider.dart';
import 'view/home/home_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared/theme.dart';
import 'view/auth/auth_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool _seen = _prefs.getBool('seen');
  Widget screen = AuthView();
  if (_seen == true) {
    screen = HomeView();
  } else if (_seen == false || _seen == null) {
    screen = AuthView();
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
