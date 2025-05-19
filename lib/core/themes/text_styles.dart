import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static TextStyle styleRegular(
    context, {
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? ColorsManager.textBasic1Color,
      fontSize: (fontSize ?? 16).sp,
      fontFamily: fontFamily ?? 'Lato',
      fontWeight: fontWeight ?? FontWeight.w500,
    );
  }

  static TextStyle styleMedium(
    context, {
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? ColorsManager.textBasic1Color,
      fontSize: (fontSize ?? 16).sp,
      fontFamily: fontFamily ?? 'Lato',
      fontWeight: fontWeight ?? FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold(
    context, {
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? ColorsManager.textBasic1Color,
      fontSize: (fontSize ?? 16).sp,
      fontFamily: fontFamily ?? 'Lato',
      fontWeight: fontWeight ?? FontWeight.w700,
    );
  }

  static TextStyle styleBold(
    context, {
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? ColorsManager.textBasic1Color,
      fontSize: (fontSize ?? 16).sp,
      fontFamily: fontFamily ?? 'Lato',
      fontWeight: fontWeight ?? FontWeight.w800,
    );
  }
}
