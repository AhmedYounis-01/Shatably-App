// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/projects/ui/custom_service_package_screen.dart';

class KitchenInstallation extends StatelessWidget {
  const KitchenInstallation({super.key});

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
      title: "Kitchen installation",
      description:
          "Transform your kitchen with expert installation from start to finish. Our skilled team handles everything with precision—from cabinets and countertops to sinks, appliances, and more. We ensure a smooth, hassle-free experience with a perfect finish every time.",
      imagePath: AppImages.kitchenImage,

      // Thumbnails Images
      firstThumbnail: AppImages.kitchenImage1,
      secondThumbnail: AppImages.kitchenImage2,
      thirdThumbnail: AppImages.kitchenImage3,

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
