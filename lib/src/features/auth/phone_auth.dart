import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_x/src/features/auth/otp_view.dart';
import 'package:video_x/src/features/auth/provider/auth_provider.dart';
import 'package:video_x/src/features/home/presention/view/home_v.dart';
import 'package:video_x/src/share/navigator/navigator.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/text_styling.dart';
import 'package:video_x/src/share/utils/ui_helper.dart';
import 'package:video_x/src/share/widget/custom_button.dart';
import 'package:video_x/src/share/widget/custom_textfield.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    const String image = 'assets/images/videoX.png';
    return Scaffold(body: Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 100,
              ),
              addVertSpace(150),
              Row(
                children: [
                  DropdownButton(
                      underline: Container(),
                      borderRadius: BorderRadius.circular(20),
                      value: auth.selectedCode,
                      items: auth.zipCode.map((String e) {
                        return DropdownMenuItem(
                          child: Text(
                            e,
                            style: VxTypography.vXTextStyle(context).copyWith(
                                color: VxColor.brandColor,
                                fontWeight: FontWeight.bold),
                          ),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                        auth.validate(value);
                        //  auth.selectedCode = val;
                      }),
                  Expanded(
                    child: VxTextField(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter Phone number',
                      textController: auth.authController,
                    ),
                  ),
                ],
              ),
              addVertSpace(100),
              VxPrimaryButton(
                  isEnabled: true,
                  buttonTitle: auth.getCode,
                  textColor: auth.isSending == false
                      ? VxColor.whiteColor
                      : VxColor.blackColor,
                  color: auth.isSending == false
                      ? VxColor.brandColor
                      : Colors.grey.withOpacity(0.3),
                  onPressed: auth.isSending == false
                      ? () {
                          if (auth.authController.text.isNotEmpty) {
                            final String number =
                                auth.selectedCode + auth.authController.text;
                            print(number);
                            VxNavigator.displayBottomSheet(context, OtpView());
                            auth.verifyPhone(context, number);
                          }
                        }
                      : () {})
            ],
          ),
        );
      },
    ));
  }
}
