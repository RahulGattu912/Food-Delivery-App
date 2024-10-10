import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignin extends StatefulWidget {
  const GoogleSignin({super.key});
  @override
  State<GoogleSignin> createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State<GoogleSignin> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false; // Loading state

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign-In Demo'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show loading indicator
            : _user == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _signInWithGoogle,
                        child: const Text('Sign in with Google'),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hello, ${_user!.displayName}!'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signOut,
                        child: const Text('Sign out'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
