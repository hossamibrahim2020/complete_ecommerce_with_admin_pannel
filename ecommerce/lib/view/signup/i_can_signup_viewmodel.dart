import 'package:ecommerce/models/is_loding_provider.dart';
import 'package:ecommerce/view/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICanSignUP {
  Future<void> regester(
    String email,
    String password,
    BuildContext context,
    IsLoding _isLoding,
  ) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _isLoding.loding();
      if (userCredential != null) {
        // true mean user is auth
        _prefs.setBool('seen', true);
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      } else {
        _isLoding.notLoding();
      }
    } on FirebaseAuthException catch (e) {
      _isLoding.notLoding();
      if (e.code == 'weak-password') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Password is very weak'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Email is exists '),
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
