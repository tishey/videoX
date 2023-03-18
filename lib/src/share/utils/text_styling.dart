import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_x/src/share/utils/color.dart';
import 'package:video_x/src/share/utils/strings.dart';

class VxTypography {
  VxTypography._();

  static TextStyle headLineTypograpy =
      TextStyle(fontSize: 24.sp, fontFamily: VxString.knormalBoldString);
  static TextStyle headLineMediumTypograpy =
      TextStyle(fontSize: 24.sp, fontFamily: VxString.knormalString);
  static TextStyle subtitleTypography =
      TextStyle(fontSize: 11.sp, fontFamily: VxString.knormalString);
  static TextStyle butonTypography =
      TextStyle(fontSize: 24.sp, fontFamily: VxString.knormalString);
  static TextStyle captionTypography =
      TextStyle(fontSize: 24.sp, fontFamily: VxString.knormalBoldString);
       static TextStyle buttonTypography =
      TextStyle(fontSize: 24.sp, fontFamily: VxString.knormalBoldString);
  static TextStyle titleLargeTypography = headLineTypograpy;
  static TextStyle titleMediumTypography = headLineMediumTypograpy;
  

  static TextStyle bodyTypography = TextStyle(
    fontSize: 13.sp,
    color: VxColor.whiteColor,
    fontFamily: VxString.knormalString,
  );
  static TextStyle bodyLargeTypography = bodyTypography.copyWith(
    fontSize: 17.sp,
  );
  static TextStyle bodyMediumTypography = bodyTypography.copyWith(
    fontSize: 14.sp,
  );
  static TextStyle bodySmallTypography = bodyTypography.copyWith(
    fontSize: 11.sp,
  );

 static TextStyle vXTextStyle(BuildContext context){
      return TextStyle(
        fontFamily: 'Geometria',
        fontSize: 16
      );
    }
}



   
  
