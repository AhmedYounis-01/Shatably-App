import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';

class BookingRepository {
  final ApiConsumer _apiConsumer;
  BookingRepository(this._apiConsumer);
  Future<BookingResponseModel> bookService(
    BookingRequestModel bookingRequest,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.booking,
      data: bookingRequest.toJson(),
    );
    return BookingResponseModel.fromJson(response.data);
  }
}
