
 import 'package:flutter/material.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/text_styling.dart';

class VxTheme{
   VxTheme._();
   static ThemeData get defaultTheme {
  return ThemeData(
    scaffoldBackgroundColor: VxColor.whiteColor,
    primaryColor: VxColor.brandColor,
   primaryColorLight: VxColor.lightBrandColor,
   textTheme: TextTheme(
        bodyMedium: VxTypography.bodyMediumTypography.copyWith(),
        bodyLarge: VxTypography.bodyLargeTypography.copyWith(),
        bodySmall: VxTypography.bodySmallTypography.copyWith(),
        titleLarge: VxTypography.titleLargeTypography,
        // titleMedium: VxTypography.titleMediumTypography
        // titleSmall: VxTypography.titleSmall,
        // headlineLarge: HaffaTextStyle.headlineLarge,
        headlineMedium: VxTypography.headLineMediumTypograpy,
        headlineSmall: VxTypography.headLineTypograpy,
        labelLarge: VxTypography.butonTypography,
      ),
  );
}
 }