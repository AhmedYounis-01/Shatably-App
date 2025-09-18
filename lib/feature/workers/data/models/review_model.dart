class ReviewModel {
  final String name;
  final int rating;
  final String comment;
  final int daysAgo;

  const ReviewModel({
    required this.name,
    required this.rating,
    required this.comment,
    required this.daysAgo,
  });
}
