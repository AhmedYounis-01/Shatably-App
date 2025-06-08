import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/workers/ui/custom_worker.dart';

class WorkerScreen extends StatelessWidget {
  const WorkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWorkerScreen(
      providerName: "Mohamed Ahmed",
      profession: "Electrician - Plumber",
      profileImage: AppImages.workerImage2, // Add your image asset
    );
  }
}
