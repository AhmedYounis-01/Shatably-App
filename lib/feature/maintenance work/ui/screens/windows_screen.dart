import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/custom_works.dart';

class WindowsScreen extends StatelessWidget {
  const WindowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMaintenanceWorkScreen(
      title: 'windows & doors',
      backgroundImage: AppImages.windowsImage,
      serviceTitle: 'Seamless repairs for a flawless home.',
      serviceDetails:
          'From stuck windows to squeaky doors, we restore function and style—fast. Enjoy smoother operation, better insulation, and boosted...',
      price: '300 EGP',
      filters: [
        {'icon': AppIcons.airConditionerIcon, 'label': 'Clean water'},
        {'icon': AppIcons.wrenchIcon, 'label': 'Fast setup'},
        {'icon': AppIcons.renewIcon, 'label': 'Green solutions'},
      ],
      onBookNow: () {
        // Book Now action
      },
      workers: [WorkerInfo(rating: 2, reviewCount: 70)],
    );
  }
}
