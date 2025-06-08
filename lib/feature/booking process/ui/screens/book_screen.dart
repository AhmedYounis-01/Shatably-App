import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/booking%20process/ui/custom_booking.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBookingScreen(image: AppImages.youngMan);
  }
}
