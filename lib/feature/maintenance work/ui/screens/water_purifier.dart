import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/custom_works.dart';

class WaterPurifierScreen extends StatelessWidget {
  const WaterPurifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMaintenanceWorkScreen(
      title: 'water purifier',
      backgroundImage: AppImages.waterFilterImage,
      serviceTitle: 'Pure water, straight from the source.',
      serviceDetails:
          'ay goodbye to impurities and hello to crisp, clean water. Our expert installation ensures you get the best in water filtration—efficient, reliable...',
      price: '400 EGP',
      filters: [
        {'icon': AppIcons.airConditionerIcon, 'label': 'install'},
        {'icon': AppIcons.wrenchIcon, 'label': 'Repair'},
        {'icon': AppIcons.renewIcon, 'label': 'Renew'},
      ],
      onBookNow: () {
        // Book Now action
      },
      workers: [WorkerInfo(rating: 3, reviewCount: 55)],
    );
  }
}
