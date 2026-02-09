import 'package:bloc/bloc.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';
import 'package:shatably_app/feature/booking%20process/data/repository/book_repository.dart';
import 'package:shatably_app/feature/booking%20process/logic/booking%20cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._bookingRepository)
    : super(const BookingState(status: BookingStates.initial));
  final BookingRepository _bookingRepository;

  Future<void> bookService(BookingRequestModel bookingRequest) async {
    emit(state.copyWith(status: BookingStates.loading));
    try {
      final response = await _bookingRepository.bookService(bookingRequest);
      emit(
        state.copyWith(
          status: BookingStates.success,
          bookingResponseModel: response,
        ),
      );
    } on ServerFailure catch (err) {
      emit(
        state.copyWith(status: BookingStates.error, errorMessage: err.message),
      );
    } catch (e) {
      emit(
        state.copyWith(status: BookingStates.error, errorMessage: e.toString()),
      );
    }
  }

  void logBookingId() {
    final bookingId = state.bookingResponseModel?.bookingId;
    if (bookingId != null) {
      print('✅ Booking ID موجود: $bookingId');
    } else {
      print('❌ Booking ID غير موجود أو null');
    }
  }
}
