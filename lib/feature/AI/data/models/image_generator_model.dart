class ImageRequestModel {
  final String prompt;

  ImageRequestModel({required this.prompt});

  Map<String, dynamic> toJson() {
    return {'prompt': prompt};
  }
}

class ImageResponseModel {
  final String imageData;
  final String format;

  ImageResponseModel({required this.imageData, required this.format});

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) {
    return ImageResponseModel(
      imageData: json['image_data'] ?? '',
      format: json['format'] ?? 'base64',
    );
  }

  Map<String, dynamic> toJson() {
    return {'image_data': imageData, 'format': format};
  }
}