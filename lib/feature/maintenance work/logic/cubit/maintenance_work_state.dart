// part of 'maintenance_work_cubit.dart';

// @immutable
// abstract class MaintenanceWorkStates {}

// class MaintenanceWorkInitial extends MaintenanceWorkStates {}

// class MaintenanceWorkLoadingState extends MaintenanceWorkStates {}

// class MaintenanceWorkSuccessState extends MaintenanceWorkStates {
//   // Holds a single service model for display in the detail screen
//   final MaintenanceServiceModel serviceModel;
//   MaintenanceWorkSuccessState(this.serviceModel);
// }

// class MaintenanceWorkErrorState extends MaintenanceWorkStates {
//   final String message;
//   MaintenanceWorkErrorState(this.message);
// }
import 'package:flutter/foundation.dart';
import 'package:shatably_app/feature/maintenance%20work/data/model/maintenance_work_model.dart';

enum ServicesStatus { initial, loading, success, error }

extension MaintenanceWorkStatesX on MaintenanceWorkState {
  bool get isInitial => status == ServicesStatus.initial;
  bool get isLoading => status == ServicesStatus.loading;
  bool get isSuccess => status == ServicesStatus.success;
  bool get isError => status == ServicesStatus.error;
}

@immutable
class MaintenanceWorkState {
  final ServicesStatus status;
  final String? errorMessage;
  final MaintenanceServiceModel? maintenanceServiceModel;

  const MaintenanceWorkState({
    required this.status,
    this.errorMessage,
    this.maintenanceServiceModel,
  });

  MaintenanceWorkState copyWith({
    ServicesStatus? status,
    String? errorMessage,
    MaintenanceServiceModel? maintenanceServiceModel,
  }) {
    return MaintenanceWorkState(
      maintenanceServiceModel:
          maintenanceServiceModel ?? this.maintenanceServiceModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // String toString() =>
  //     'KhatmaState(status: $status, currentKhatma: $currentKhatma, currentWerdInfo: $currentWerdInfo, werds: $werds, currentPageIndex: $currentPageIndex, currentProgress: $currentProgress)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MaintenanceWorkState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.maintenanceServiceModel == maintenanceServiceModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      maintenanceServiceModel.hashCode;
}
