// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/hire_details_model.dart';

//! دي بتاعت  stripe  لو عايز تستخدمها
// class HireDetailsRepository {
//   final StripeService stripeService;

//   HireDetailsRepository({required this.stripeService});

//   Future<void> makePayment({
//     required PaymentIntentInputModel paymentIntentInputModel,
//   }) async {
//     try {
//       //  PaymentIntent  ل    impelement   ويعمل   services  هيروح علي ال
//       await stripeService.makePayment(
//         paymentIntentInputModel: paymentIntentInputModel,
//       );
//     } on StripeException catch (e) {
//       print(e.toString());
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }

class HireDetailsRepository {
  final ApiConsumer _apiConsumer;

  HireDetailsRepository(this._apiConsumer);

  Future<BookingDetailsResponseModel> bookingPaymentById(
    BookingDetailsRequestModel bookingDetailsRequestModel,
  ) async {
    try {
      final bookingId = bookingDetailsRequestModel.bookingId;
      if (bookingId.isEmpty) {
        throw Exception('Booking ID is required');
      }

      final endpoint = EndPoints.getBookingPaymentEndpoint(bookingId);

      print("🔍 Final Endpoint: $endpoint");
      print("🔍 Request Body: ${bookingDetailsRequestModel.toJson()}");

      final response = await _apiConsumer.post(
        endpoint,
        data: bookingDetailsRequestModel.toJson(),
      );

      print("🔍 Response: ${response.data}");

      return BookingDetailsResponseModel.fromJson(response.data);
    } on ServerFailure catch (err) {
      print('Error fetching booking payment details: $err');
      rethrow;
    }
  }
}
