import 'package:firebase_auth/firebase_auth.dart';
import 'package:greenland_stock/db/user.dart' as u;
import 'package:greenland_stock/screens/utils/hash_generator.dart';
import 'package:greenland_stock/services/response_utils.dart';
import 'package:greenland_stock/services/user_service.dart';
import 'package:greenland_stock/services/user_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  dynamic registerWithMobileNumber(int mobileNumber, int countryCode,
      String passkey, String firstName, String lastName, String uid) async {
    try {
      u.User user = u.User();
      String hKey = HashGenerator.hmacGenerator(
          passkey, countryCode.toString() + mobileNumber.toString());
      user.password = hKey;
      user.mobileNumber = mobileNumber;
      user.countryCode = countryCode;
      user.firstName = firstName;
      user.lastName = lastName;
      user.guid = uid;
      user = await user.create();

      var platformData = await UserFCM().getPlatformDetails();

      if (platformData != null) {
        user.updatePlatformDetails({"platform_data": platformData});
      }

      user.update({'last_signed_in_at': DateTime.now()});
      user.lastSignInTime = DateTime.now();

      // cache the user data
      cachedLocalUser = user;

      return CustomResponse.getSuccesReponse(user.toJson());
    } catch (err) {
      return CustomResponse.getFailureReponse(err.toString());
    }
  }

  dynamic signInWithMobileNumber(String userID) async {
    try {
      Map<String, dynamic> _userData = await u.User().getByID(userID);
      u.User user = u.User.fromJson(_userData);

      var platformData = await UserFCM().getPlatformDetails();

      if (platformData != null) {
        user.updatePlatformDetails({"platform_data": platformData});
      }

      // update cloud firestore "users" collection
      user.update({'last_signed_in_at': DateTime.now()});

      // cache the user data
      cachedLocalUser = user;

      return CustomResponse.getSuccesReponse(user);
    } catch (err) {
      return CustomResponse.getFailureReponse(err.toString());
    }
  }

  dynamic signOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    try {
      await _auth.signOut();
      final SharedPreferences prefs = await _prefs;
      await prefs.remove("mobile_number");
      await prefs.setBool("user_session_live", false);

      return CustomResponse.getSuccesReponse("Successfully signed out");
    } catch (err) {
      return CustomResponse.getFailureReponse(err.toString());
    }
  }
}
