import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/feature/Appointments/data/sample/appointments_sample.dart';
import 'package:shatably_app/feature/Appointments/ui/widgets/appointment_card.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: ListView.builder(
        itemCount: kCompletedAppointments.length,
        itemBuilder: (context, index) {
          final appointment = kCompletedAppointments[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < kCompletedAppointments.length - 1 ? 16.h : 0,
            ),
            child: AppointmentCard(appointment: appointment),
          );
        },
      ),
    );
  }
}
