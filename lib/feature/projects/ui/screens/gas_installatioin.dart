// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/projects/ui/custom_service_package_screen.dart';

class GasInstallatioinScreen extends StatelessWidget {
  const GasInstallatioinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Creating a list of review items for the handymen service package
    final List<ReviewItemModel> handymenReviews = [
      ReviewItemModel(
        name: "Khaled R",
        rating: 5,
        comment:
            "I was really impressed with how fast and professional the handyman was. He fixed everything I needed in just one visit—no stress, no mess! Definitely booking this service again.",
        daysAgo: "2 days ago",
        avatarPath: AppIcons.personIcon,
      ),
      ReviewItemModel(
        name: "Youssef K",
        rating: 5,
        comment:
            "Very convenient! The handyman arrived on time and handled all the small repairs around my apartment. It saved me so much time and effort.",
        daysAgo: "3 days ago",
        avatarPath: AppIcons.personIcon,
      ),
      ReviewItemModel(
        name: "Mona A",
        rating: 5,
        comment:
            "I manage several rental units, and this service is a game-changer. Everything gets done in one go, and the quality is consistent. Reliable and professional.",
        daysAgo: "6 days ago",
        avatarPath: AppIcons.personIcon,
      ),
    ];

    return CustomServicePackageScreen(
      // Service Details
      title: "Gas installation",
      description:
          "Ensure safe, efficient, and professional gas installation for your home or business.\nOur certified technicians handle everything from piping to appliance connections—following the highest safety standards.",
      imagePath: AppImages.gasImage,

      // Thumbnails Images
      firstThumbnail: AppImages.gasImage1,
      secondThumbnail: AppImages.gasImage2,
      thirdThumbnail: AppImages.gasImage3,

      serviceDuration: "4 Hour Service",
      currentPrice: 500,
      originalPrice: 600,
      isCompleted: true,

      // Reviews
      reviews: handymenReviews,

      // Callbacks
      onBackPressed: () {
        Navigator.pop(context);
      },
      onBookNowPressed: () {
        // Add your booking logic here
      },
      onGiveRatingPressed: () {
        // Add your rating logic here
      },

      // UI Controls
      showBookNowButton: true,
      showRatingButton: false, // Set to true to show the rating button instead
    );
  }
}
