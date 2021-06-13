import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class UserFCM {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future getPlatformDetails() async {
    try {
      String fcmToken = await _fcm.getToken();

      if (kIsWeb)
        return {'token': fcmToken};
      else if (fcmToken != null) {
        return {
          'token': fcmToken,
          'created_at': DateTime.now(),
          'platform': Platform.operatingSystem,
          'version': Platform.operatingSystemVersion,
          'local_name': Platform.localeName
        };
      }
      return null;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
