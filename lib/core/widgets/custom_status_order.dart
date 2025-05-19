// lib/feature/tasks/ui/widget/task_status_widgets/status_item.dart
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/text_styles.dart';

class StatusItem extends StatelessWidget {
  final String icon;
  final bool isCompleted;
  final String description;
  final String date;
  final IconData? endIcon;
  final VoidCallback? onOrderStateChange;

  const StatusItem({
    super.key,
    required this.icon,
    required this.isCompleted,
    required this.description,
    required this.date,
    this.endIcon,
    this.onOrderStateChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (isCompleted)
              Icon(
                Icons.check_circle,
                color: ColorsManager.primaryColor,
                size: 20,
              )
            else
              InkWell(
                onTap: onOrderStateChange,
                child: const Icon(
                  Icons.radio_button_unchecked,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            CustomPaint(
              size: const Size(2, 60),
              painter: DottedLinePainter(),
            ),
          ],
        ),
        const SizedBox(width: 12),
        // الجزء الأوسط: عرض النصوص (الوصف والتاريخ)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyles.styleSemiBold(context, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyles.styleRegular(
                  context,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // الجزء الأخير: عرض الأيقونة
        SvgPicture.asset(
          icon,
          height: 30,
          width: 30,
          colorFilter: ColorFilter.mode(
            ColorsManager.primaryColor,
            BlendMode.srcIn,
          ),
        )
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = size.width
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
