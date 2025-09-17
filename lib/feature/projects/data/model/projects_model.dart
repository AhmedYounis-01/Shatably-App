class ProjectsModel {
  final String projectId;
  final String title;
  final String description;
  final String mainImageUrl;
  final List<String> imageUrls;
  final int hourService; // سيظل int لأنه يُعرض كـ 'X Hour Service'
  final String hourServiceDisplay;
  final double price;
  final List<RatingReview> ratingReview;

  ProjectsModel({
    required this.projectId,
    required this.title,
    required this.description,
    required this.mainImageUrl,
    required this.imageUrls,
    required this.hourService,
    required this.hourServiceDisplay,
    required this.price,
    required this.ratingReview,
  });

  factory ProjectsModel.fromJson(Map<String, dynamic> json) {
    return ProjectsModel(
      projectId: json['projectId'],
      title: json['title'],
      description: json['description'],
      mainImageUrl: json['mainImageUrl'],
      imageUrls: List<String>.from(json['imageUrls']),
      hourService:
          (json['hourService'] as num).toInt(), // ★ تم تعديل هذا السطر ★
      hourServiceDisplay: json['hourServiceDisplay'],
      price: (json['price'] as num).toDouble(),
      ratingReview:
          (json['ratingReview'] as List)
              .map((e) => RatingReview.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'description': description,
      'mainImageUrl': mainImageUrl,
      'imageUrls': imageUrls,
      'hourService': hourService,
      'hourServiceDisplay': hourServiceDisplay,
      'price': price,
      'ratingReview': ratingReview.map((e) => e.toJson()).toList(),
    };
  }
}

class RatingReview {
  final String reviewId;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final String clientId;

  RatingReview({
    required this.reviewId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.clientId,
  });

  factory RatingReview.fromJson(Map<String, dynamic> json) {
    return RatingReview(
      reviewId: json['reviewId'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      clientId: json['clientId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'clientId': clientId,
    };
  }
}

class ProjectsResponseModel {
  final int pageSize;
  final int pageIndex;
  final int totalCount;
  final List<ProjectsModel> data;

  ProjectsResponseModel({
    required this.pageSize,
    required this.pageIndex,
    required this.totalCount,
    required this.data,
  });

  factory ProjectsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProjectsResponseModel(
      pageSize: json['pageSize'],
      pageIndex: json['pageIndex'],
      totalCount: json['totalCount'],
      data:
          (json['data'] as List).map((e) => ProjectsModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pageSize': pageSize,
      'pageIndex': pageIndex,
      'totalCount': totalCount,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
