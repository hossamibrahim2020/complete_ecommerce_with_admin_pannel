import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/firebase_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

abstract class SendMessageViewmodel {
  void send(String email, String message, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection(messages).add({
        messagekey: message,
        'emailkeyForMessage': email,
      });
      Toast.show(
        'Message Send',
        context,
        duration: 3,
      );
    } on PlatformException catch (e) {
      Toast.show(
        '${e.message}',
        context,
        duration: 3,
      );
    }
  }
}
