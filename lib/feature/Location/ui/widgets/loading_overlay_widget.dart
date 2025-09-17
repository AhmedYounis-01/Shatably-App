import 'package:flutter/material.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';

class LoadingOverlayWidget extends StatelessWidget {
  const LoadingOverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Center(
        child: CircularProgressIndicator(color: ColorsManager.primaryColor),
      ),
    );
  }
}
