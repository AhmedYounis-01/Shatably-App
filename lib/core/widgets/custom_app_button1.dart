import 'package:flutter/material.dart';
import '../themes/colors_manager.dart';

class CustomAppButton1 extends StatelessWidget {
  const CustomAppButton1({
    super.key,
    required this.width,
    required this.height,
    this.onPressed,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderRadius,
    required this.child,
    this.isCircular = false,
    this.hasShadow = false, // Default value
  });

  final double width, height;
  final void Function()? onPressed;
  final double? borderRadius;
  final TextStyle? style;
  final Color? backgroundColor,
      foregroundColor,
      disabledForegroundColor,
      disabledBackgroundColor;
  final Widget child;
  final bool isCircular;
  final bool hasShadow; // New property

  @override
  Widget build(BuildContext context) {
    return isCircular
        ? ClipOval(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: foregroundColor ?? Colors.white,
              backgroundColor: backgroundColor ?? ColorsManager.primaryColor,
              disabledBackgroundColor:
                  disabledBackgroundColor ??
                  ColorsManager.primaryColor.withAlpha(50),
              disabledForegroundColor: disabledForegroundColor ?? Colors.white,
              minimumSize: Size(width, height),
              shape: const CircleBorder(),
              elevation:
                  hasShadow ? 7.0 : 0.0, // Apply shadow if hasShadow is true
            ),
            child: child,
          ),
        )
        : ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor ?? Colors.white,
            backgroundColor: backgroundColor ?? ColorsManager.primaryColor,
            disabledBackgroundColor:
                disabledBackgroundColor ??
                ColorsManager.primaryColor.withAlpha(50),
            disabledForegroundColor: disabledForegroundColor ?? Colors.white,
            minimumSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            ),
            elevation:
                hasShadow ? 7.0 : 0.0, // Apply shadow if hasShadow is true
          ),
          child: child,
        );
  }
}
