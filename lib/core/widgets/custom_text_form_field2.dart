import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';

// First component: Simple input field without label above
class CustomTextFormField2 extends StatefulWidget {
  final String hintText;
  final double? fontSize;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType inputType;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final String? suffixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final bool? readOnly;
  final double? hintWordSpacing;
  final double? textWordSpacing;

  const CustomTextFormField2({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.inputType = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.readOnly,
    this.fontSize,
    this.hintWordSpacing,
    this.textWordSpacing,
  });

  @override
  State<CustomTextFormField2> createState() => _SimpleInputFieldState();
}

class _SimpleInputFieldState extends State<CustomTextFormField2> {
  final bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      cursorColor: ColorsManager.primaryColor,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.isPassword ? !_isPasswordVisible : false,
      keyboardType: widget.inputType,
      // textAlign: TextAlign.center, // Center the input text
      maxLines: widget.maxLines,
      validator: widget.validator,

      style: TextStyle(
        color: Colors.black87, // Replace with your color
        fontSize: 11.sp,
        wordSpacing: widget.textWordSpacing ?? 0,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Color.fromRGBO(22, 64, 77, 0.33),
          fontSize: widget.fontSize ?? 16,
          wordSpacing: widget.hintWordSpacing ?? 0,
        ),
        fillColor: Color.fromRGBO(217, 217, 217, 1),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0, // Adjust vertical padding to fit the height
          horizontal: 16,
        ),
        constraints: BoxConstraints(
          minHeight: 30.h, // Set the height to 30.h
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ColorsManager.primaryColor,
          ), // Your primary color
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: Padding(
          padding: EdgeInsets.all(6.5.w),

          child: SvgPicture.asset(widget.suffixIcon ?? ''),
        ),
        // widget.isPassword
        //     ? IconButton(
        //       icon: Icon(
        //         _isPasswordVisible
        //             ? Icons.visibility
        //             : Icons.visibility_off,
        //         color: Colors.grey,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           _isPasswordVisible = !_isPasswordVisible;
        //         });
        //       },
        //     )
        //     : widget.suffixIcon,
      ),
    );
  }
}
