import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/feature/Appointments/data/models/appointment_model.dart';

const List<AppointmentModel> kUpcomingAppointments = [
  AppointmentModel(
    name: "Mohamed Ahmed",
    profession: "Electrician · Plumber",
    date: "16 June 2025",
    time: "2PM to 5PM",
    duration: "3 Hours",
    profileImage: AppImages.menWorkerImage2,
    isUpcoming: true,
  ),
  AppointmentModel(
    name: "Yasmen Karim",
    profession: "Carpenter",
    date: "16 June 2025",
    time: "2PM to 5PM",
    duration: "3 Hours",
    profileImage: AppImages.womanWorkerImage2,
    isUpcoming: true,
  ),
];

const List<AppointmentModel> kCompletedAppointments = [
  AppointmentModel(
    name: "Mohamed Ahmed",
    profession: "Electrician · Plumber",
    date: "16 June 2025",
    time: "2PM to 5PM",
    duration: "3 Hours",
    profileImage: AppImages.menWorkerImage3,
    isUpcoming: false,
  ),
  AppointmentModel(
    name: "Yasmen Karim",
    profession: "Carpenter",
    date: "16 June 2025",
    time: "2PM to 5PM",
    duration: "3 Hours",
    profileImage: AppImages.womanWorkerImage2,
    isUpcoming: false,
  ),
];
