class BookingDetailsRequestModel {
  final String bookingId;

  BookingDetailsRequestModel({required this.bookingId});

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
    };
  }
}
class BookingDetailsResponseModel {
  final String bookingId;
  final DateTime bookingDate;
  final String? status;
  final String? timeSlot;
  final double totalPrice;
  final String? clientId;
  final String? workerId;
  final String? portfolioId;
  final String? serviceId;
  final dynamic location; // You can replace this with a specific Location model if known
  final String paymentIntentId;
  final String clientSecret;

  BookingDetailsResponseModel({
    required this.bookingId,
    required this.bookingDate,
    required this.status,
    required this.timeSlot,
    required this.totalPrice,
    required this.clientId,
    required this.workerId,
    required this.portfolioId,
    required this.serviceId,
    required this.location,
    required this.paymentIntentId,
    required this.clientSecret,
  });

  factory BookingDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsResponseModel(
      bookingId: json['bookingId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      status: json['status'],
      timeSlot: json['timeSlot'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      clientId: json['clientId'],
      workerId: json['workerId'],
      portfolioId: json['portfolioId'],
      serviceId: json['serviceId'],
      location: json['location'],
      paymentIntentId: json['paymentIntentId'],
      clientSecret: json['clientSecret'],
    );
  }
}
