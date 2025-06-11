import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/routes/routes.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';
import 'package:shatably_app/core/widgets/custom_text_form_feild.dart';
import 'package:shatably_app/feature/auth/login/data/repository/login_repository.dart';
import 'package:shatably_app/feature/auth/login/logic/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenAdvancedState();
}

class _LoginScreenAdvancedState extends State<LoginScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFieldFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_textFieldFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _scrollController.animateTo(
            200.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _scrollController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return BlocProvider(
      create: (context) => LoginCubit(sl<LoginRepository>()),
      child: BlocBuilder<LoginCubit, LoginStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                Image.asset(
                  AppImages.loginImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                // Content with animated positioning
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
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: keyboardHeight > 0 ? 200.h : 450.h,
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: keyboardHeight > 0 ? 0.8 : 1.0,
                                child: Text(
                                  'Login',
                                  style: TextStyles.styleBold(
                                    context,
                                    fontSize:
                                        keyboardHeight > 0 ? 36.sp : 44.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: keyboardHeight > 0 ? 0.7 : 1.0,
                                child: Text(
                                  'Good to see you back!',
                                  style: TextStyles.styleBold(
                                    context,
                                    fontSize:
                                        keyboardHeight > 0 ? 16.sp : 18.sp,
                                    color: ColorsManager.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 23.h),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow:
                                      keyboardHeight > 0
                                          ? [
                                            BoxShadow(
                                              color: ColorsManager.primaryColor
                                                  .withAlpha(
                                                    (0.1 * 255).toInt(),
                                                  ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                          : [],
                                ),
                                child: CustomTextFormField(
                                  hintText: 'Email or phone',
                                  textAlign: TextAlign.start,
                                  controller: _emailController,
                                  focusNode: _textFieldFocusNode,
                                ),
                              ),
                              SizedBox(height: 23.h),
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
                                              final email =
                                                  _emailController.text.trim();
                                              Navigator.pushNamed(
                                                context,
                                                Routes.passwordScreen,
                                                arguments: email,
                                              );
                                            }
                                          },

                                  child: Center(
                                    child:
                                        state is LoginLoadingState
                                            ? CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.5,
                                            )
                                            : Text(
                                              "Next",
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
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account? ',
                                    style: TextStyles.styleMedium(
                                      context,
                                      fontSize: 16.sp,
                                      color: Color.fromRGBO(22, 64, 77, 0.4),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigate to sign up screen
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyles.styleMedium(
                                        context,
                                        fontSize: 14.sp,
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
