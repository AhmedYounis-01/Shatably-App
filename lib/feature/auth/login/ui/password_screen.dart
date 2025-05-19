import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';

class CustomPinTextField extends StatefulWidget {
  final TextEditingController controller;
  final int pinLength;
  final bool obscureText;
  final Function(String) onCompleted;

  const CustomPinTextField({
    Key? key,
    required this.controller,
    this.pinLength = 6,
    this.obscureText = true,
    required this.onCompleted,
  }) : super(key: key);

  @override
  State<CustomPinTextField> createState() => _CustomPinTextFieldState();
}

class _CustomPinTextFieldState extends State<CustomPinTextField> {
  late List<String> _pin;
  late int _currentIndex;

  // إضافة FocusNode خاص بحقل النص المخفي
  final FocusNode _textFieldFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _pin = List.filled(widget.pinLength, '');
    _currentIndex = 0;

    // الاستماع للتغييرات في المتحكم
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _textFieldFocus.dispose(); // التأكد من التخلص من FocusNode
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.controller.text;

    // تحديث مصفوفة الرموز بالقيم الجديدة
    for (int i = 0; i < widget.pinLength; i++) {
      if (i < text.length) {
        _pin[i] = text[i];
      } else {
        _pin[i] = '';
      }
    }

    _currentIndex = text.length;

    // التحقق مما إذا كان الرمز مكتملاً
    if (text.length == widget.pinLength) {
      widget.onCompleted(text);
    }

    setState(() {});
  }

  // دالة لإعادة التركيز على حقل النص
  void _refocusTextField() {
    // طلب التركيز على حقل النص المخفي
    _textFieldFocus.requestFocus();
    // تحديد موضع المؤشر في نهاية النص
    widget.controller.selection = TextSelection.fromPosition(
      TextPosition(offset: widget.controller.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // حقل النص المخفي للتعامل مع الإدخال الفعلي
        Opacity(
          opacity: 0,
          child: TextField(
            controller: widget.controller,
            focusNode: _textFieldFocus, // استخدام FocusNode المحدد
            keyboardType: TextInputType.number,
            maxLength: widget.pinLength,
            autofocus: true,
          ),
        ),

        // عرض PIN المخصص
        GestureDetector(
          onTap: _refocusTextField, // استدعاء الدالة الجديدة عند النقر
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
      // إضافة GestureDetector لكل مربع PIN
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

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  // إضافة متغير لتتبع ما إذا كان تم تمكين لوحة المفاتيح
  // ignore: unused_field
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    // تأخير صغير للسماح ببناء النافذة قبل إظهار لوحة المفاتيح
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
    // استخدم هذا لمعرفة ما إذا كانت لوحة المفاتيح مرئية
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      // إزالة أي لون خلفية من الـ scaffold
      backgroundColor: Colors.transparent,
      // استخدم resizeToAvoidBottomInset لمنع لوحة المفاتيح من دفع المحتوى للأعلى
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand, // جعل المكدس يملأ الشاشة بأكملها
        children: [
          // صورة الخلفية - ثابتة وتغطي الشاشة بأكملها
          Image.asset(
            AppImages.passwordImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // طبقة المحتوى
          SafeArea(
            child: Column(
              children: [
                // المحتوى الرئيسي في Expanded لأخذ المساحة المتاحة
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 90.h),

                          // مساحة الصورة الشخصية
                          Center(
                            child: Container(
                              width: 116.w,
                              height: 116.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorsManager.backGroundFormsColor,
                              ),
                            ),
                          ),

                          SizedBox(height: 42.h),

                          Text(
                            'Hello, Morgan',
                            style: TextStyles.styleSemiBold(
                              context,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.primaryColor,
                            ),
                          ),

                          SizedBox(height: 33.h),

                          Text(
                            'Type your password',
                            style: TextStyles.styleRegular(
                              context,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.primaryColor,
                            ),
                          ),

                          SizedBox(height: 30.h),

                          // حقل إدخال رمز PIN
                          CustomPinTextField(
                            controller: _passwordController,
                            pinLength: 6,
                            obscureText: true,
                            onCompleted: (pin) {
                              // معالجة إدخال كلمة المرور المكتملة
                              print('تم إكمال الرمز: $pin');
                              // هنا يمكنك تنفيذ التحقق من كلمة المرور أو الانتقال
                            },
                          ),

                          SizedBox(height: 15.h),

                          // رابط نسيت كلمة المرور
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                  EdgeInsetsGeometry
                                >(EdgeInsets.zero),
                                overlayColor: MaterialStateProperty.all<Color>(
                                  ColorsManager.primaryColor.withOpacity(0.05),
                                ),
                              ),
                              onPressed: () {
                                // الانتقال إلى شاشة نسيت كلمة المرور
                              },
                              child: Text(
                                'Forgot password?',
                                style: TextStyles.styleSemiBold(
                                  context,
                                  fontSize: 16.sp,
                                  color: Color.fromRGBO(22, 64, 77, 0.4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // الجزء السفلي الثابت مع نص "ليس أنت؟"
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
                          // العودة إلى شاشة تسجيل الدخول
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
        ],
      ),
    );
  }
}
