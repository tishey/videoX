
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/extensions.dart';

class VxTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool? readOnly;
  final Function(String)? onChanged;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final Color? inputColor;
  final Widget? suffixIcon;

  VxTextField({
    required this.hintText,
    required this.textController,
    this.onChanged,
    this.onTap,
    this.readOnly,
    this.textAlign,
    this.keyboardType,
    this.inputColor,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      
      controller: textController,
      readOnly: readOnly ?? false,
      cursorColor: VxColor.brandColor,
      style: context.theme.textTheme.bodyMedium!.copyWith(color: inputColor ?? VxColor.blackColor, fontSize: 17.sp),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        isDense: true,
        hintStyle: theme.textTheme.bodyMedium!
            .copyWith(color: VxColor.brandColor.withOpacity(0.5)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: VxColor.brandColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: VxColor.brandColor, width: 2)),
        hintText: hintText,
        focusColor: Colors.white,
      ),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
