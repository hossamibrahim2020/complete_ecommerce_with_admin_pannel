import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../models/is_loding_provider.dart';
import '../auth/auth_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ICanSignoutViewmodel {
  Future<void> signOut(BuildContext context) async {
    final _isLoding = Provider.of<IsLoding>(context,listen: false);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        _isLoding.loding();
        _prefs.setBool('seen', false);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AuthView(),
          ),
          (route) => false,
        );
        return _isLoding.notLoding();
      });
    } on PlatformException catch (e) {
      Toast.show('${e.message}', context);
    }
  }
}
