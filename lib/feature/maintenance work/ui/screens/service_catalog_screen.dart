import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/maintenance%20work/ui/custom_works.dart';

class PestControlPage extends StatelessWidget {
  const PestControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMaintenanceWorkScreen(
      title: 'Pest control',
      backgroundImage: AppImages.bestControlImage,
      serviceTitle: 'Protect your space, the smart way.',
      serviceDetails:
          'From ants to rodents, we eliminate pests quickly and safely using eco-friendly methods. Protect your home or workspace with solutions...',
      price: '600 EGP',
      filters: [
        {'icon': AppIcons.namosaIcon, 'label': 'bug control'},
        {'icon': AppIcons.mouseIcon, 'label': 'mouse removal'},
        {'icon': AppIcons.treeIcon, 'label': 'green methods'},
      ],
      onBookNow: () {
        // Book Now action
      },
      workers: [WorkerInfo(rating: 4, reviewCount: 52)],
    );
  }
}
