import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserFCM {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future getPlatformDetails() async {
    try {
      String fcmToken = await _fcm.getToken();

      // Save it to Firestore
      if (fcmToken != null) {
        var data = {
          'token': fcmToken,
          'created_at': DateTime.now(),
          'platform': Platform.operatingSystem,
          'version': Platform.operatingSystemVersion,
          'local_name': Platform.localeName
        };

        return data;
      }
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
