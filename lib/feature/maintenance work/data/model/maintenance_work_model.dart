class MaintenanceServiceModel {
  final String serviceId;
  final String name;
  final String details;
  final String description;
  final String imageUrl;
  final double price;
  final double averageRating;
  final int reviewCount;

  MaintenanceServiceModel({
    required this.serviceId,
    required this.name,
    required this.details,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.averageRating,
    required this.reviewCount,
  });

  factory MaintenanceServiceModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceServiceModel(
      serviceId: json['serviceId'],
      name: json['name'],
      details: json['details'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      averageRating: (json['averageRating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
    );
  }
}
