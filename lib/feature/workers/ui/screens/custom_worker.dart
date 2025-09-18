import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/feature/workers/data/sample/worker_profile_sample.dart';
import 'package:shatably_app/feature/workers/ui/widgets/worker_about.dart';
import 'package:shatably_app/feature/workers/ui/widgets/worker_bottom_actions.dart';
import 'package:shatably_app/feature/workers/ui/widgets/worker_header.dart';
import 'package:shatably_app/feature/workers/ui/widgets/worker_reviews.dart';

class CustomWorkerScreen extends StatefulWidget {
  final String providerName;
  //! profession not used now
  final String profession;
  final String profileImage;

  const CustomWorkerScreen({
    super.key,
    required this.providerName,
    required this.profession,
    required this.profileImage,
  });

  @override
  State<CustomWorkerScreen> createState() => _CustomWorkerScreenState();
}

class _CustomWorkerScreenState extends State<CustomWorkerScreen> {
  bool showBookNowButton = true;
  bool showRatingButton = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Color(0XFFD9D8DB),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: 50.h),
                // Header Section with Image and Navigation
                WorkerHeader(
                  providerName: widget.providerName,
                  profession: widget.profession,
                  profileImage: widget.profileImage,
                  yearsOfExperience: kYearsOfExperience,
                  rating: kAverageRating,
                  currentPrice: kCurrentPriceEgpt,
                ),

                // Main Content
                Transform.translate(
                  offset: Offset(0, -20.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFD9D8DB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((.25 * 255).toInt()),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // About Section
                          WorkerAbout(aboutText: kAboutText),

                          SizedBox(height: 23.h),

                          // Reviews Section
                          WorkerReviews(reviews: kSampleReviews),

                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action Buttons
          WorkerBottomActions(onHireNow: () {}, onChat: () {}),
        ],
      ),
    );
  }
}
