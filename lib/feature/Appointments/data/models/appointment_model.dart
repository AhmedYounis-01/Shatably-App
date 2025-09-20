class AppointmentModel {
  final String name;
  final String profession;
  final String date;
  final String time;
  final String duration;
  final String profileImage;
  final bool isUpcoming;

  const AppointmentModel({
    required this.name,
    required this.profession,
    required this.date,
    required this.time,
    required this.duration,
    required this.profileImage,
    required this.isUpcoming,
  });
}
