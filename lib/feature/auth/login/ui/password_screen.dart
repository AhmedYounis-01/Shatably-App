import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/Location/ui/screens/location_screen.dart';
import 'package:shatably_app/feature/auth/login/data/repository/login_repository.dart';
import 'package:shatably_app/feature/auth/login/logic/cubit/login_cubit.dart';
import 'package:toastification/toastification.dart';

//! Custom pin text field
class CustomPinTextField extends StatefulWidget {
  final TextEditingController controller;
  final int pinLength;
  final bool obscureText;
  final Function(String) onCompleted;

  const CustomPinTextField({
    super.key,
    required this.controller,
    this.pinLength = 6,
    this.obscureText = true,
    required this.onCompleted,
  });

  @override
  State<CustomPinTextField> createState() => _CustomPinTextFieldState();
}

class _CustomPinTextFieldState extends State<CustomPinTextField> {
  late List<String> _pin;
  late int _currentIndex;
  final FocusNode _textFieldFocus = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _pin = List.filled(widget.pinLength, '');
    _currentIndex = 0;
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    _textFieldFocus.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _handleTextChange() {
    _onTextChanged(widget.controller.text);
  }

  void _onTextChanged(String text) {
    setState(() {
      for (int i = 0; i < widget.pinLength; i++) {
        _pin[i] = i < text.length ? text[i] : '';
      }
      _currentIndex = text.length.clamp(0, widget.pinLength);
    });

    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 3), () {
      if (text.length >= widget.pinLength) {
        widget.onCompleted(text);
      }
    });
  }

  void _refocusTextField() {
    _textFieldFocus.requestFocus();
    widget.controller.selection = TextSelection.fromPosition(
      TextPosition(offset: widget.controller.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(
          opacity: 0,
          child: TextField(
            controller: widget.controller,
            focusNode: _textFieldFocus,
            keyboardType: TextInputType.visiblePassword,
            style: const TextStyle(color: Colors.transparent),
            cursorColor: Colors.transparent,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            onSubmitted: (text) {
              if (text.length >= widget.pinLength) {
                widget.onCompleted(text);
              }
            },
          ),
        ),
        GestureDetector(
          onTap: _refocusTextField,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.pinLength,
              (index) => _buildPinBox(index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinBox(int index) {
    final bool isFilled = _pin[index].isNotEmpty;
    final bool isCurrent = index == _currentIndex;

    return GestureDetector(
      onTap: _refocusTextField,
      child: Container(
        width: 44.w,
        height: 44.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: ColorsManager.backGroundFormsColor,
          borderRadius: BorderRadius.circular(8),
          border:
              isCurrent
                  ? Border.all(color: ColorsManager.primaryColor, width: 2)
                  : null,
        ),
        child: Center(
          child:
              widget.obscureText && isFilled
                  ? Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.primaryColor,
                    ),
                  )
                  : Text(
                    isFilled ? _pin[index] : '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
        ),
      ),
    );
  }
}

//! Password screen
class PasswordScreen extends StatefulWidget {
  final String email;

  const PasswordScreen({super.key, required this.email});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  // ignore: unused_field
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return BlocProvider(
      create:
          (context) =>
              LoginCubit(sl<LoginRepository>())..setEmail(widget.email),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);

            if (state is LoginSuccessState) {
              customToast(
                context: context,
                message: "Login Successfully",
                type: ToastificationType.success,
                icon: Icons.check,
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LocationDetectionScreen()),
              );
              // context.pushReplacementNamed(Routes.locationDetectionScreen);
            } else if (state is LoginErrorState) {
              customToast(
                context: context,
                message: "Login Failed",
                type: ToastificationType.error,
                icon: Icons.error,
              );
            }
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppImages.passwordImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 85.h),

                                  Center(
                                    child: Container(
                                      width: 116.w,
                                      height: 116.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color:
                                        //     ColorsManager.backGroundFormsColor,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AppImages.morganImage,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 40.h),

                                  Text(
                                    'Hello, Morgan',
                                    style: TextStyles.styleSemiBold(
                                      context,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsManager.primaryColor,
                                    ),
                                  ),

                                  SizedBox(height: 30.h),

                                  Text(
                                    'Type your password',
                                    style: TextStyles.styleRegular(
                                      context,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsManager.primaryColor,
                                    ),
                                  ),

                                  // SizedBox(height: 30.h),
                                  CustomPinTextField(
                                    controller: _passwordController,
                                    pinLength: 6,
                                    obscureText: true,
                                    onCompleted: (pin) {
                                      if (!_isLoading) {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.loginWithPassword(
                                            _passwordController.text,
                                          );
                                        }

                                        print('تم إكمال الرمز: $pin');
                                      }
                                    },
                                  ),

                                  SizedBox(height: 15.h),

                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        padding: WidgetStateProperty.all<
                                          EdgeInsetsGeometry
                                        >(EdgeInsets.zero),
                                        overlayColor:
                                            WidgetStateProperty.all<Color>(
                                              ColorsManager.primaryColor
                                                  .withAlpha(
                                                    (0.05 * 255).toInt(),
                                                  ),
                                            ),
                                      ),
                                      onPressed: () {
                                        context.pushNamed(
                                          Routes.forgotPasswordScreen,
                                        );
                                      },
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyles.styleSemiBold(
                                          context,
                                          fontSize: 16.sp,
                                          color: Color.fromRGBO(
                                            22,
                                            64,
                                            77,
                                            0.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 50.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Not you?",
                                style: TextStyles.styleRegular(
                                  context,
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 18.w,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: ColorsManager.primaryColor,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
