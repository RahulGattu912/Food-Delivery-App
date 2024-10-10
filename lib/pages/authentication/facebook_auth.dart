// facebook_signin.dart
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/pages/homepage/home_page.dart';

class FacebookSignin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        await _auth.signInWithCredential(credential);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        debugPrint('Facebook login failed: ${result.status}');
      }
    } catch (e) {
      debugPrint('Error during Facebook login: $e');
    }
  }
}
