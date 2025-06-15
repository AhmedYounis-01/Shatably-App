import 'package:flutter/material.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/book_model.dart';
import 'package:shatably_app/feature/booking%20process/data/models/model____for%20me/hire_details_model.dart';

enum HireDetailsStates { initial, loading, success, error }

extension HireDetailsStatesX on HireDetailsState {
  bool get isInitial => status == HireDetailsStates.initial;
  bool get isLoading => status == HireDetailsStates.loading;
  bool get isSuccess => status == HireDetailsStates.success;
  bool get isError => status == HireDetailsStates.error;
}

@immutable
class HireDetailsState {
  final HireDetailsStates status;
  final String? errorMessage;
  final BookingDetailsResponseModel? bookingDetailsResponseModel;
  final BookingResponseModel? bookingResponseModel;

  const HireDetailsState({
    required this.status,
    this.errorMessage,
    this.bookingDetailsResponseModel,
    this.bookingResponseModel,
  });

  HireDetailsState copyWith({
    HireDetailsStates? status,
    String? errorMessage,
    BookingDetailsResponseModel? bookingDetailsResponseModel,
    BookingResponseModel? bookingResponseModel,
  }) {
    return HireDetailsState(
      bookingDetailsResponseModel:
          bookingDetailsResponseModel ?? this.bookingDetailsResponseModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bookingResponseModel: bookingResponseModel ?? this.bookingResponseModel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HireDetailsState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.bookingResponseModel == bookingResponseModel &&
        other.bookingDetailsResponseModel == bookingDetailsResponseModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      bookingResponseModel.hashCode ^
      bookingDetailsResponseModel.hashCode;
}
