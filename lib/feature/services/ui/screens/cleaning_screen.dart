import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/services/custom_services.dart';

class CleaningServiceScreen extends StatelessWidget {
  const CleaningServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define mock data for electrician workers
    final List<WorkerInfo> cleaningWorkers = [
      WorkerInfo(
        name: "Mohamed Ahmed",
        imagePath: AppImages.menWorkerImage3,
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
        imagePath: AppImages.menWorkerImage2,
        rating: 3,
        reviewCount: 20,
      ),
       
    ];

    // Use the custom ServiceWorkerScreen widget
    return ServiceWorkerScreen(
      title: "Cleaning services",
      workerIcon: AppIcons.housekeepingIcon,
      backgroundImage: AppImages.cleaningImage,
      backgroundColor: Color(0XFFFBF5DD),
      backgroundOpacity: .32,
      workers: cleaningWorkers,
      jobTitle: "Cleaner",
      workerProfileImage: AppImages.shopPlumbImage4,
    );
  }
}
