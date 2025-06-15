class BookingRequestModel {
  final String bookingDate;
  final String timeSlot;
  final String? clientId;
  final String? workerId;
  final String? portfolioId;
  final String serviceId;
  final Location location;

  BookingRequestModel({
    required this.bookingDate,
    required this.timeSlot,
    this.clientId,
    this.workerId,
    this.portfolioId,
    required this.serviceId,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookingDate": bookingDate,
      "timeSlot": timeSlot,
      "clientId": clientId,
      "workerId": workerId,
      "portfolioId": portfolioId,
      "serviceId": serviceId,
      "location": location.toJson(),
    };
  }
}

class BookingResponseModel {
  final String bookingId;
  final String bookingDate;
  final String status;
  final String timeSlot;
  final double totalPrice;
  final String? clientId;
  final String? workerId;
  final String? portfolioId;
  final String serviceId;
  final Location location;
  final String? paymentIntentId;
  final String? clientSecret;

  BookingResponseModel({
    required this.bookingId,
    required this.bookingDate,
    required this.status,
    required this.timeSlot,
    required this.totalPrice,
    this.clientId,
    this.workerId,
    this.portfolioId,
    required this.serviceId,
    required this.location,
    this.paymentIntentId,
    this.clientSecret,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      bookingId: json['bookingId'],
      bookingDate: json['bookingDate'],
      status: json['status'],
      timeSlot: json['timeSlot'],
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      clientId: json['clientId'],
      workerId: json['workerId'],
      portfolioId: json['portfolioId'],
      serviceId: json['serviceId'],
      location: Location.fromJson(json['location']),
      paymentIntentId: json['paymentIntentId'],
      clientSecret: json['clientSecret'],
    );
  }
}

class Location {
  final double latitude;
  final double longitude;
  final String address;
  final String description;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      address: json['address'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "description": description,
    };
  }
}
