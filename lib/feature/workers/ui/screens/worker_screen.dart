// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shatably_app/feature/workers/ui/custom_worker.dart';

class WorkerScreen extends StatelessWidget {
  final String workerName;
  final String workerProf;
  final String workerImage;
  const WorkerScreen({
    super.key,
    required this.workerName,
    required this.workerProf,
    required this.workerImage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomWorkerScreen(
      providerName: workerName,
      profession: workerProf,
      profileImage: workerImage,
    );
  }
}
