import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';

class LabeledInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType inputType;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final bool? readOnly;
  final double fontSize;

  const LabeledInputField({
    super.key,
    required this.labelText,
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
    required this.fontSize,
  });

  @override
  State<LabeledInputField> createState() => _LabeledInputFieldState();
}

class _LabeledInputFieldState extends State<LabeledInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.labelText,
            style: TextStyles.styleSemiBold(
              context,
              fontSize: 16,
              color: Color(0XFF2A2A2A), // Replace with your text color
            ),
          ),
        ),
        TextFormField(
          readOnly: widget.readOnly ?? false,
          cursorColor: ColorsManager.primaryColor, // Primary color
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: widget.isPassword ? !_isPasswordVisible : false,
          keyboardType: widget.inputType,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          validator: widget.validator,
          style: TextStyle(
            color: ColorsManager.primaryColor,
            fontSize: widget.fontSize,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: ColorsManager.primaryColor.withAlpha((33 * 255).toInt()),
              fontSize: 14.sp,
            ),
            // fillColor: Color.fromRGBO(217, 217, 217, 1),
            fillColor: Color(0XFFD9D9D9),
            // fillColor: Color(0XFFD94551),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: ColorsManager.primaryColor,
              ), // Your primary color
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                    : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
