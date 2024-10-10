import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneSignIn extends StatefulWidget {
  final String phoneNumber;

  const PhoneSignIn({super.key, required this.phoneNumber});

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isOtpSent = false;
  String _verificationId = '';
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
      _isOtpSent = false;
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
        smsCode: _otp,
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
    final primaryColor = Theme.of(context).primaryColor;
    final indicatorColor = Theme.of(context).indicatorColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final bodyLarge = Theme.of(context).textTheme.bodyLarge;
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    // final labelSmall = Theme.of(context).textTheme.labelSmall;
    // final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return Scaffold(
        body: _isOtpSent
            ? const Center(child: CircularProgressIndicator())
            : _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              'OTP Verification',
                              style: headlineMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 10),
                            child: Text(
                              'Enter the verification code we just sent on your phone number.',
                              style: bodyLarge,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              children: [
                                PinCodeTextField(
                                  textStyle: bodyLarge?.copyWith(
                                      color: const Color(0xff333333)),
                                  appContext: context,
                                  length: 6,
                                  onChanged: (value) {
                                    setState(() {
                                      _otp = value;
                                    });
                                  },
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    selectedColor: primaryColor,
                                    selectedFillColor: primaryColor,
                                    inactiveColor: indicatorColor,
                                    activeColor: primaryColor,
                                  ),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 48,
                                  width: 342,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(primaryColor),
                                      foregroundColor: WidgetStateProperty.all(
                                          const Color(0xFFFFFFFF)),
                                    ),
                                    onPressed: _signInWithOtp,
                                    child: Text(
                                      'Verify',
                                      style: titleMedium?.copyWith(
                                          color: const Color(0xFFFFFFFF)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
