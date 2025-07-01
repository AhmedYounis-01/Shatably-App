class ProductsRequestModel {
  final String category;

  ProductsRequestModel({required this.category});
}

class ProductsResponseModel {
  final String productId;
  final String name;
  final String category;
  final num price;
  final String details;
  final int? stockAmount;
  final String imageUrl;
  final bool isPackage;

  ProductsResponseModel({
    required this.productId,
    required this.name,
    required this.category,
    required this.price,
    required this.details,
    required this.stockAmount,
    required this.imageUrl,
    required this.isPackage,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      productId: json['productId'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      details: json['details'],
      stockAmount: json['stockAmount'],
      imageUrl: json['imageUrl'],
      isPackage: json['isPackage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'category': category,
      'price': price,
      'details': details,
      'stockAmount': stockAmount,
      'imageUrl': imageUrl,
      'isPackage': isPackage,
    };
  }
}
