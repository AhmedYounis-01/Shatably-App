import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/feature/Appointments/data/sample/appointments_sample.dart';
import 'package:shatably_app/feature/Appointments/ui/widgets/appointment_card.dart';

class UpcomingAppointments extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  const UpcomingAppointments({super.key, this.onCancel, this.onReschedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: ListView.builder(
        itemCount: kUpcomingAppointments.length,
        itemBuilder: (context, index) {
          final appointment = kUpcomingAppointments[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < kUpcomingAppointments.length - 1 ? 16.h : 0,
            ),
            child: AppointmentCard(
              appointment: appointment,
              onCancel: onCancel,
              onReschedule: onReschedule,
            ),
          );
        },
      ),
    );
  }
}
