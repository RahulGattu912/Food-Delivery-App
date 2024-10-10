import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneSignIn extends StatefulWidget {
  final String phoneNumber;

  const PhoneSignIn({super.key, required this.phoneNumber});

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  bool _isOtpSent = false;
  String _verificationId = '';

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          if (!mounted) return;
          Navigator.pop(context);
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isOtpSent = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      debugPrint('Error verifying phone number: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithOtp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );

      await _auth.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error signing in with OTP: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Sign-In'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isOtpSent) ...[
                    const SizedBox(height: 20),
                    TextField(
                      controller: _otpController,
                      decoration: const InputDecoration(labelText: 'OTP'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _signInWithOtp,
                      child: const Text('Verify OTP'),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
