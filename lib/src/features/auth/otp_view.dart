import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_x/src/features/auth/provider/auth_provider.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/text_styling.dart';
import 'package:video_x/src/share/utils/ui_helper.dart';
import 'package:video_x/src/share/widget/custom_button.dart';
import 'package:video_x/src/share/widget/custom_textfield.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, codeSms, value) {
      return Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
          height: screenHeight(context) / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('OTP',
                  style: VxTypography.vXTextStyle(context)
                      .copyWith(fontWeight: FontWeight.bold)),
              addVertSpace(40),
              VxTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter Code',
                  textController: codeSms.otpController),
              const Spacer(),
              VxSecondaryButton(
                color: codeSms.otpController.text.isNotEmpty
                    ? VxColor.brandColor
                    : Colors.grey.withOpacity(0.3),
                buttonTitle: codeSms.isLoading == false
                    ? Text(
                        'Continue',
                        style: VxTypography.bodyLargeTypography
                            .copyWith(color: VxColor.whiteColor),
                      )
                    : SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                            color: VxColor.whiteColor, strokeWidth: 2)),
                onPressed: codeSms.isLoading == false
                    ? () {
                        if (codeSms.otpController.text.isNotEmpty) {
                          codeSms.verifyCode(
                              context, codeSms.otpController.text.toString());
                        }
                      }
                    : () {},
                isEnabled: true,
              )
            ],
          ));
    });
  }
}
