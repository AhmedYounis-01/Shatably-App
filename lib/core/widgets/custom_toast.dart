import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../themes/text_styles.dart';

void customToast({
  required BuildContext context,
  required String message,
  Color? primaryColor,
  Color? backgroundColor,
  ToastificationType type = ToastificationType.success,
  ToastificationStyle style = ToastificationStyle.flatColored,
  Duration autoCloseDuration = const Duration(seconds: 3),
  Alignment alignment = Alignment.topRight,
  TextDirection direction = TextDirection.ltr,
  Duration animationDuration = const Duration(milliseconds: 300),
  IconData icon = Icons.check,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  List<BoxShadow> boxShadow = const [
    BoxShadow(
      color: Color(0x07000000),
      blurRadius: 16,
      offset: Offset(0, 16),
      spreadRadius: 0,
    )
  ],
  bool showProgressBar = true,
  CloseButtonShowType closeButtonShowType = CloseButtonShowType.onHover,
  bool closeOnClick = true,
  bool pauseOnHover = true,
  bool dragToClose = true,
  bool applyBlurEffect = true,
  ToastificationCallbacks? callbacks,
}) {
  Toastification().show(
    context: context,
    type: type,
    style: style,
    autoCloseDuration: autoCloseDuration,
    description: RichText(
      text: TextSpan(
        text: message,
        style: TextStyles.styleMedium(
          context,
          fontSize: 16,
          color: ColorsManager.textBasic1Color,
        ),
      ),
    ),
    alignment: alignment,
    direction: direction,
    animationDuration: animationDuration,
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: Icon(icon, color: ColorsManager.textBasic1Color),
    showIcon: true,
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    foregroundColor: ColorsManager.textBasic1Color,
    padding: padding,
    margin: margin,
    borderRadius: borderRadius,
    boxShadow: boxShadow,
    showProgressBar: showProgressBar,
    closeButtonShowType: closeButtonShowType,
    closeOnClick: closeOnClick,
    pauseOnHover: pauseOnHover,
    dragToClose: dragToClose,
    applyBlurEffect: applyBlurEffect,
    callbacks:
        callbacks ?? ToastificationCallbacks(), // Provide a default value
  );
}
