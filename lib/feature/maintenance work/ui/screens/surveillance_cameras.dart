import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/custom_works.dart';

class SurveillanceCameras extends StatelessWidget {
  const SurveillanceCameras({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMaintenanceWorkScreen(
      title: 'Surveillance Cameras',
      backgroundImage: AppImages.houseCamera,
      serviceTitle: 'Smart security starts at your doorstep.',
      serviceDetails:
          'Protect what matters with smart, reliable surveillance cameras. Whether you’re home or away, monitor in real time and stay one step...',
      price: '500 EGP',
      filters: [
        {'icon': AppIcons.airConditionerIcon, 'label': 'install'},
        {'icon': AppIcons.wrenchIcon, 'label': 'Repair'},
        {'icon': AppIcons.renewIcon, 'label': 'Renew'},
      ],
      onBookNow: () {
        // Book Now action
      },
      workers: [WorkerInfo(rating: 5, reviewCount: 75)],
    );
  }
}
