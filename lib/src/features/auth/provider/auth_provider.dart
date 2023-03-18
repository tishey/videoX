import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_x/src/features/home/presention/view/home_v.dart';
import 'package:video_x/src/share/navigator/navigator.dart';
import 'package:video_x/src/share/utils/text_styling.dart';
import 'package:video_x/src/share/widget/custom_button.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController authController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String selectedCode = '+234';

  List<String> zipCode = ['+234', '+91'];

  String selectzipCodeImage = 'assets/images/nigeria (1).png';

  String getCode = 'GET CODE';
  bool isSending = false;
  bool isLoading = false;

  Timer? codeTimer;

  String myVerificationId = '';

  void verifyPhone(BuildContext context, number) async {
    int timeDuration = 60;
    codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      isSending = true;
      if (timeDuration < 1) {
        codeTimer!.cancel();
        isSending = false;
        getCode = 'Get Code';
      } else {
        timeDuration--;
        getCode = '$timeDuration s';
      }
      notifyListeners();
    });
    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          VxNavigator.navigateAndRemoveUntilRoute( HomeView());
        },
        timeout: const Duration(seconds: 60),
        verificationFailed: (FirebaseException e) {
          showErrorMessage(context, e.code);
          // ScaffoldMessenger.of(context)
          //     .showSnackBar((SnackBar(content: Text(e.code))));
        },
        codeSent: (verificationId, forceResendingToken) {
          myVerificationId = verificationId;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {});
  }

  validate(val) {
    selectedCode = val;
    notifyListeners();
  }

// verifying code
  void verifyCode(BuildContext context, String code) async {

    FirebaseAuth _auth = FirebaseAuth.instance;
    isLoading = true;
    notifyListeners();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: myVerificationId, smsCode: code);
         //sign in with credential
        await _auth.signInWithCredential(credential);
        isLoading = false;
        VxNavigator.navigateAndRemoveUntilRoute(HomeView());
         notifyListeners();
  }
 
}

  showErrorMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: VxTypography.vXTextStyle(context).copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp),
            ),
            content: Text(message, style: VxTypography.vXTextStyle(context)),
            actions: [
              VxPrimaryButton(
                isEnabled: true,
                onPressed: () => Navigator.pop(context),
                buttonTitle: 'OK',
              )
            ],
          );
        });
  }