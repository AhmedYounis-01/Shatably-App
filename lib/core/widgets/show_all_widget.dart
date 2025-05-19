import 'package:shatably_app/core/localization/localization_extension.dart';
import 'package:flutter/material.dart';

import '../themes/text_styles.dart';

class ShowAllWidget extends StatelessWidget {
  const ShowAllWidget({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 5,
        children: [
          Text(
            "tasks.show_all".t(context),
            style: TextStyles.styleRegular(context, fontSize: 14),
          ),
          Icon(Icons.arrow_forward, size: 12),
        ],
      ),
    );
  }
}
