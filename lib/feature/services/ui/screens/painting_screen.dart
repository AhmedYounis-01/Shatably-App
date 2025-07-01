import 'package:flutter/material.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/services/custom_services.dart';

class PaintingServiceScreen extends StatelessWidget {
  const PaintingServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define mock data for electrician workers
    final List<WorkerInfo> paintianWorkers = [
      WorkerInfo(
        name: "Mohamed Ahmed",
        imagePath: AppImages.menWorkerImage2,
        rating: 5,
        reviewCount: 30,
      ),
      WorkerInfo(
        name: "Yasmen Karim",
        imagePath: AppImages.womanWorkerImage1,
        rating: 5,
        reviewCount: 20,
      ),
      WorkerInfo(
        name: "Ziad Ahmed",
        imagePath: AppImages.menWorkerImage3,
        rating: 3,
        reviewCount: 20,
      ),
      WorkerInfo(
        name: "Samir Nagy",
        imagePath: AppImages.menWorkerImage4,
        rating: 5,
        reviewCount: 14,
      ),
    ];

    // Use the custom ServiceWorkerScreen widget
    return ServiceWorkerScreen(
      title: "Painting services",
      workerIcon: AppIcons.painterIcon,
      backgroundImage: AppImages.paintingImage,
      backgroundColor: ColorsManager.primaryColor,
      backgroundOpacity: .60,
      workers: paintianWorkers,
      jobTitle: "Painter",
      workerProfileImage: AppImages.shopPlumbImage4,
    );
  }
}
