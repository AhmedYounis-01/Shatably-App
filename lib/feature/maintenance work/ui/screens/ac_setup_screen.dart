import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/custom_works.dart';

class AcSetupScreen extends StatelessWidget {
  const AcSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMaintenanceWorkScreen(
      title: 'AC Setup',
      backgroundImage: AppImages.acSetupImage,
      serviceTitle: 'Cool down with expert AC installation.',
      serviceDetails:
          'Get fast and reliable AC installation by certified experts. We handle everything from setup to testing, ensuring your space stays cool and....',
      price: '350 EGP',
      filters: [
        {'icon': AppIcons.airConditionerIcon, 'label': 'install'},
        {'icon': AppIcons.wrenchIcon, 'label': 'Repair'},
        {'icon': AppIcons.renewIcon, 'label': 'Renew'},
      ],
      onBookNow: () {
        // Book Now action
      },
      workers: [WorkerInfo(rating: 5, reviewCount: 44)],
    );
  }
}
