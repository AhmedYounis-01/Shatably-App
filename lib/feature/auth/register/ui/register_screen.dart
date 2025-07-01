import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/helpers/extensions.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/auth/register/data/repository/register_repository.dart';
import 'package:shatably_app/feature/auth/register/logic/cubit/register_cubit.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  // Added for animation
  final ScrollController _scrollController = ScrollController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add listeners to all text field focus nodes
    _firstNameFocusNode.addListener(_onFocusChange);
    _lastNameFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
    _phoneFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // Check if any of the text fields have focus
    if (_firstNameFocusNode.hasFocus ||
        _lastNameFocusNode.hasFocus ||
        _emailFocusNode.hasFocus ||
        _phoneFocusNode.hasFocus ||
        _passwordFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _scrollController.animateTo(
            250.0, // Adjust this value as needed to scroll past the keyboard
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

    // Dispose all focus nodes
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (context) => RegisterCubit(sl<RegisterRepository>()),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);

            if (state is RegisterSuccess) {
              customToast(
                context: context,
                message: "Registration Successfully",
                type: ToastificationType.success,
                icon: Icons.check,
              );
              context.pushReplacementNamed(Routes.locationDetectionScreen);
            } else if (state is RegisterError) {
              customToast(
                context: context,
                message: "Registration Failed",
                type: ToastificationType.error,
                icon: Icons.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                Image.asset(
                  AppImages.registerImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                // Content layer
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(
                    bottom: keyboardHeight > 0 ? keyboardHeight : 0,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SingleChildScrollView(
                        controller:
                            _scrollController, // Assign the scroll controller
                        physics: const ClampingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height:
                                    keyboardHeight > 0
                                        ? 100.h
                                        : 250.h, // Adjust this as needed
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: keyboardHeight > 0 ? 0.8 : 1.0,
                                child: Text(
                                  'Register',
                                  style: TextStyles.styleBold(
                                    context,
                                    fontSize:
                                        keyboardHeight > 0 ? 36.sp : 44.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                              ),

                              SizedBox(height: 30.h),

                              // First Name and Last Name in a row
                              Row(
                                children: [
                                  // First Name
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'First Name*',
                                      fontSize: 14.sp,
                                      textAlign: TextAlign.start,
                                      controller: _firstNameController,
                                      focusNode:
                                          _firstNameFocusNode, // Assign focus node
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'First name is required';
                                        }
                                        if (value.length < 5) {
                                          return 'Name must be more than five character';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  // Last Name
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Last Name*',
                                      fontSize: 14.sp,
                                      textAlign: TextAlign.start,
                                      controller: _lastNameController,
                                      focusNode:
                                          _lastNameFocusNode, // Assign focus node
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Last name is required';
                                        }
                                        if (value.length < 5) {
                                          return 'Name must be more than five character';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 23.h),

                              // Email
                              CustomTextFormField(
                                hintText: 'E-mail',
                                textAlign: TextAlign.start,
                                fontSize: 14.sp,
                                inputType: TextInputType.emailAddress,
                                controller: _emailController,
                                focusNode: _emailFocusNode, // Assign focus node
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 23.h),

                              // Phone Number
                              CustomTextFormField(
                                hintText: 'Phone Number*',
                                fontSize: 14.sp,
                                textAlign: TextAlign.start,
                                inputType: TextInputType.phone,
                                controller: _phoneController,
                                focusNode: _phoneFocusNode, // Assign focus node
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone number is required';
                                  }
                                  if (value.length < 10) {
                                    return 'Phone number must be at least 10 digits';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 23.h),

                              // Password with visibility toggle
                              CustomTextFormField(
                                hintText: 'Password*',
                                textAlign: TextAlign.start,
                                fontSize: 14.sp,
                                isPassword: !_isPasswordVisible,
                                controller: _passwordController,
                                focusNode:
                                    _passwordFocusNode, // Assign focus node
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: ColorsManager.primaryColor.withAlpha(
                                      (0.5 * 255).toInt(),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 35.h),

                              // Register Button
                              AnimatedScale(
                                duration: const Duration(milliseconds: 200),
                                scale: keyboardHeight > 0 ? 0.95 : 1.0,
                                child: CustomAppButton1(
                                  width: double.infinity,
                                  height: 60,
                                  backgroundColor: ColorsManager.primaryColor,
                                  borderRadius: 25,
                                  hasShadow: true,
                                  onPressed:
                                      _isLoading
                                          ? null
                                          : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<RegisterCubit>()
                                                  .register(
                                                    _emailController.text
                                                        .trim(),
                                                    _firstNameController.text
                                                        .trim(),
                                                    _lastNameController.text
                                                        .trim(),
                                                    _passwordController.text
                                                        .trim(),
                                                    null,
                                                    null,
                                                    _phoneController.text
                                                        .trim(),
                                                  );
                                            }
                                          },
                                  child: Center(
                                    child:
                                        _isLoading
                                            ? CircularProgressIndicator(
                                              color:
                                                  ColorsManager
                                                      .whiteButtonColor,
                                              strokeWidth: 2,
                                            )
                                            : Text(
                                              "Get Started",
                                              style: TextStyles.styleBold(
                                                context,
                                                fontSize: 20.sp,
                                                color:
                                                    ColorsManager
                                                        .whiteButtonColor,
                                              ),
                                            ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 11.h),

                              // Sign In text
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account? ',
                                    style: TextStyles.styleMedium(
                                      context,
                                      fontSize: 16.sp,
                                      color: Color.fromRGBO(22, 64, 77, 0.4),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  InkWell(
                                    onTap: () {
                                      context.pushReplacementNamed(
                                        Routes.loginScreen,
                                      );
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyles.styleBold(
                                        context,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
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
