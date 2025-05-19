import 'package:flutter/material.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';

// First component: Simple input field without label above
class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final double? fontSize;
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

  const CustomTextFormField({
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
  });

  @override
  State<CustomTextFormField> createState() => _SimpleInputFieldState();
}

class _SimpleInputFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      cursorColor: ColorsManager.primaryColor,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.isPassword ? !_isPasswordVisible : false,
      keyboardType: widget.inputType,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      validator: widget.validator,
      style: TextStyle(
        color: Colors.black87, // Replace with your color
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Color.fromRGBO(22, 64, 77, 0.33),
          fontSize: widget.fontSize ?? 16,
        ),
        fillColor: Color.fromRGBO(217, 217, 217, 1),
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
    );
  }
}
