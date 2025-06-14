class ChatRequestModel {
  final String message;
  final String? image;
  final String? userId;

  ChatRequestModel({required this.message, this.image, this.userId});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (image != null) 'image': image,
      if (userId != null) 'user_id': userId,
    };
  }
}

class ChatResponseModel {
  final String response;

  ChatResponseModel({required this.response});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(response: json['response'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'response': response};
  }
}
