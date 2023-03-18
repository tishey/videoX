
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/text_styling.dart';


class VxPrimaryButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isEnabled;
  final Color? color;
  final Color? textColor;
  const VxPrimaryButton(
      {super.key,
      required this.isEnabled,
      required this.buttonTitle,
      required this.onPressed,
      this.color,
      this.textColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: MaterialButton(
        height: 50.sp,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: onPressed,
        color: color ?? VxColor.brandColor,
        
        minWidth: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonTitle,
              style: VxTypography.bodyLargeTypography.copyWith(color: textColor ?? Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}


class VxSecondaryButton extends StatelessWidget {
  final Widget buttonTitle;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isEnabled;
  final Color? color;
  final Color? textColor;
  const VxSecondaryButton(
      {super.key,
      required this.isEnabled,
      required this.buttonTitle,
      required this.onPressed,
      this.color,
      this.textColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: MaterialButton(
        height: 50.sp,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: onPressed,
        color: color ?? VxColor.brandColor,
        
        minWidth: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buttonTitle
            // Text(
            //   buttonTitle,
            //   style: VxTypography.bodyLargeTypography.copyWith(color: textColor ?? Colors.white),
            //   ),
          ],
        ),
      ),
    );
  }
}
