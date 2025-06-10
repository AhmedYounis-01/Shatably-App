import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/services/custom_services.dart';

// Update your ElectricianServiceScreen
class ElectricianServiceScreen extends StatelessWidget {
  const ElectricianServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define mock data for electrician workers
    final List<WorkerInfo> electricianWorkers = [
      WorkerInfo(
        name: "Mohamed Ahmed",
        imagePath: AppImages.youngMan,
        rating: 5,
        reviewCount: 30,
      ),
      WorkerInfo(
        name: "Yamen Karim",
        imagePath: AppImages.userImage,
        rating: 5,
        reviewCount: 20,
      ),
      WorkerInfo(
        name: "Ziad Ahmed",
        imagePath: AppImages.youngMan,
        rating: 3,
        reviewCount: 20,
      ),
      WorkerInfo(
        name: "Samir Nagy",
        imagePath: AppImages.youngMan,
        rating: 5,
        reviewCount: 14,
      ),
    ];

    // Use the updated ServiceWorkerScreen widget
    return ServiceWorkerScreen(
      title: "Electrician services",
      workerIcon: AppIcons.electricianIcon,
      backgroundImage: AppImages.manElectricalTechnician,
      backgroundColor: Color(0xFF70271C),
      backgroundOpacity: .52,
      workers: electricianWorkers,
      jobTitle: "Electrician",
      workerProfileImage: AppImages.workerImage2,
    );
  }
}
