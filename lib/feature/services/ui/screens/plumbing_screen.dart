import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/services/custom_services.dart';

class PlumbingServiceScreen extends StatelessWidget {
  const PlumbingServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define mock data for electrician workers
    final List<WorkerInfo> plumbianWorkers = [
      WorkerInfo(
        name: "Mohamed Ahmed",
        imagePath: AppImages.menWorkerImage1,
        rating: 5,
        reviewCount: 30,
      ),
      WorkerInfo(
        name: "Yasmen Karim",
        imagePath: AppImages.womanWorkerImage2,
        rating: 5,
        reviewCount: 20,
      ),
      WorkerInfo(
        name: "Ziad Ahmed",
        imagePath: AppImages.menWorkerImage3,
        rating: 3,
        reviewCount: 20,
      ),
    ];

    // Use the custom ServiceWorkerScreen widget
    return ServiceWorkerScreen(
      title: "Plumbing services",
      workerIcon: AppIcons.plumbingIcon,
      backgroundImage: AppImages.plumbingImage,
      backgroundColor: Color(0xFFA1A1A1),
      backgroundOpacity: .72,
      workers: plumbianWorkers,
      jobTitle: "Plumber",
      workerProfileImage: AppImages.shopPlumbImage4,
    );
  }
}
