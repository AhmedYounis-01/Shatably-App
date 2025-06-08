import 'package:flutter/material.dart';
import 'package:shatably_app/core/utils/app_images.dart' show AppImages;
import 'package:shatably_app/feature/booking%20process/ui/custom_booking.dart';

class BookingScreen1 extends StatelessWidget {
  const BookingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBookingScreen(image: AppImages.bookingImage1);
  }
}
