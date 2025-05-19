import 'package:flutter/material.dart';

import '../themes/colors_manager.dart';

class CustomTextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const CustomTextButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: ColorsManager.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Color(0xFF000000),
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shadowColor: Colors.black.withValues(alpha: 0.1),
        elevation: 4,
        minimumSize: Size(width, height),
      ),
      child: child,
    );
  }
}
