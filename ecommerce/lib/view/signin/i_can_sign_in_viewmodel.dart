import 'package:ecommerce/models/is_loding_provider.dart';
import '../navigation/bottom_navigation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICanSignIn {
  Future<void> signin(
    String email,
    String password,
    BuildContext context,
    IsLoding _isLoding,
  ) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _isLoding.loding();
      if (userCredential != null) {
        // true mean user is auth
        _prefs.setBool('seen', true);
        _isLoding.notLoding();
        return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomNavigationView(),
          ),
          (route) => false,
        );
      } else {
        _isLoding.notLoding();
      }
    } on FirebaseAuthException catch (e) {
      _isLoding.notLoding();
      if (e.code == 'user-not-found') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('user not found'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('wrong password'),
          ),
        );
      }
    } on PlatformException catch (e) {
      _isLoding.notLoding();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.message}'),
        ),
      );
    }
  }
}
