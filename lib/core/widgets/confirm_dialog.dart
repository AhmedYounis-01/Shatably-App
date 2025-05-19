 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/localization/localization_extension.dart';

import '../themes/text_styles.dart';
import '../utils/app_icons.dart';
import 'custom_app_button.dart';
import 'custom_text_button.dart';

class DeleteProductDialog {
  static Future<void> deletedDialog(BuildContext context,
      {required VoidCallback onDelete}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'dialogs.delete_confirm'.t(context),
                style: TextStyles.styleBold(context, fontSize: 26),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'dialogs.will_be_deleted'.t(context),
                textAlign: TextAlign.center,
                style: TextStyles.styleRegular(context, fontSize: 14),
              ),
              const SizedBox(height: 41),
              Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      width: 200,
                      height: 56,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'dialogs.cancel'.t(context),
                        style: TextStyles.styleBold(
                          context,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomAppButton(
                      width: 200,
                      height: 56,
                      backgroundColor: Colors.red,
                      onPressed: onDelete,
                      child: Text(
                        'dialogs.delete'.t(context),
                        style: TextStyles.styleBold(
                          context,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
            ],
          ),
        );
      },
    );
  }

  // يمكن الاحتفاظ بهذه الدالة لعرض رسالة النجاح بعد الحذف إذا رغبت
  static void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              SvgPicture.asset(
                AppIcons.trashIcon,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 8),
              Text(
                'dialogs.success'.t(context),
                style: TextStyles.styleBold(
                  context,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 37),
            ],
          ),
        );
      },
    );
  }
}
