import 'package:flutter/material.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';

enum BookingStates { initial, loading, success, error }

extension BookingStatesX on BookingState {
  bool get isInitial => status == BookingStates.initial;
  bool get isLoading => status == BookingStates.loading;
  bool get isSuccess => status == BookingStates.success;
  bool get isError => status == BookingStates.error;
}

@immutable
class BookingState {
  final BookingStates status;
  final String? errorMessage;
  final BookingResponseModel? bookingResponseModel;
  const BookingState({
    required this.status,
    this.errorMessage,
    this.bookingResponseModel,
  });

  BookingState copyWith({
    BookingStates? status,
    String? errorMessage,
    BookingResponseModel? bookingResponseModel,
    String? bookedServiceId,
  }) {
    return BookingState(
      bookingResponseModel: bookingResponseModel ?? this.bookingResponseModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookingState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.bookingResponseModel == bookingResponseModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ bookingResponseModel.hashCode;
}
