import 'package:bloc/bloc.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/hire_details_model.dart';
import 'package:shatably_app/feature/booking%20process/data/repository/hire_details_repository.dart';
import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_state.dart';

class HireDetailsCubit extends Cubit<HireDetailsState> {
  HireDetailsCubit(this._bookingRepository)
    : super(const HireDetailsState(status: HireDetailsStates.initial));
  final HireDetailsRepository _bookingRepository;
  Future<BookingDetailsResponseModel?> createBookingRecord(
    BookingDetailsRequestModel bookingDetailsRequest,
  ) async {
    emit(state.copyWith(status: HireDetailsStates.loading));
    dynamic response = null;
    try {
      response = await _bookingRepository.bookingPaymentById(
        bookingDetailsRequest,
      );

      emit(
        state.copyWith(
          status: HireDetailsStates.success,
          bookingDetailsResponseModel: response,
        ),
      );
    } on ServerFailure catch (err) {
      emit(
        state.copyWith(
          status: HireDetailsStates.error,
          errorMessage: err.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HireDetailsStates.error,
          errorMessage: e.toString(),
        ),
      );
    }
    return response;
  }
}
// import 'package:bloc/bloc.dart';
// import 'package:shatably_app/core/services/api/server_failure.dart';
// import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/hire_details_model.dart';
// import 'package:shatably_app/feature/booking%20process/data/repository/hire_details_repository.dart';
// import 'package:shatably_app/feature/booking%20process/logic/hire%20details/hire_details_state.dart';
// import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';

// class HireDetailsCubit extends Cubit<HireDetailsState> {
//   HireDetailsCubit(this._bookingRepository)
//     : super(const HireDetailsState(status: HireDetailsStates.initial));
//   final HireDetailsRepository _bookingRepository;

//   // إضافة method لحفظ الـ booking response
//   void setBookingResponse(BookingResponseModel bookingResponse) {
//     emit(state.copyWith(bookingResponseModel: bookingResponse));
//   }

//   Future<void> createBookingRecord(
//     BookingDetailsRequestModel bookingDetailsRequest,
//   ) async {
//     emit(state.copyWith(status: HireDetailsStates.loading));
//     try {
//       final response = await _bookingRepository.bookingPaymentById(
//         bookingDetailsRequest,
//       );

//       emit(
//         state.copyWith(
//           status: HireDetailsStates.success,
//           bookingDetailsResponseModel: response,
//         ),
//       );
//     } on ServerFailure catch (err) {
//       emit(
//         state.copyWith(
//           status: HireDetailsStates.error,
//           errorMessage: err.toString(),
//         ),
//       );
//     }
//   }

//   // Helper method للحصول على الـ booking ID
//   String? get bookingId => state.bookingResponseModel?.bookingId;
// }
