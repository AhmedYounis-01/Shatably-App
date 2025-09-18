import 'package:shatably_app/feature/workers/data/models/review_model.dart';

const int kCurrentPriceEgpt = 350;
const int? kOriginalPriceEgpt = null;
const String kServiceDuration = "1 Hour";
const int kYearsOfExperience = 10;
const double kAverageRating = 4.9;

const String kAboutText =
    "Mohamed is a skilled and reliable electrician with years of hands-on experience. From fixing power issues to installing lighting and sockets, he delivers clean, safe, and efficient work every time. Book Mohamed for professional service you can trust.";

const List<ReviewModel> kSampleReviews = [
  ReviewModel(
    name: "Khaled R",
    rating: 5,
    comment:
        "I was really impressed with how fast and professional the handyman was. He fixed everything I needed in just one visit—no stress, no mess! Definitely looking hire again.",
    daysAgo: 2,
  ),
  ReviewModel(
    name: "Youssef K",
    rating: 5,
    comment:
        "Very convenient! The handyman arrived on time and handled all the small repairs around my apartment. It saved me so much time and effort.",
    daysAgo: 3,
  ),
];
