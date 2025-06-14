import 'package:flutter/foundation.dart';
import 'package:shatably_app/feature/projects/data/model/projects_model.dart';

enum ServicesStatus { initial, loading, success, error }

extension ProjectsStatesX on ProjectsState {
  bool get isInitial => status == ServicesStatus.initial;
  bool get isLoading => status == ServicesStatus.loading;
  bool get isSuccess => status == ServicesStatus.success;
  bool get isError => status == ServicesStatus.error;
}

@immutable
class ProjectsState {
  final ServicesStatus status;
  final String? errorMessage;
  final ProjectsModel? projectsModel;

  const ProjectsState({
    required this.status,
    this.errorMessage,
    this.projectsModel,
  });

  ProjectsState copyWith({
    ServicesStatus? status,
    String? errorMessage,
    ProjectsModel? projectsModel,
  }) {
    return ProjectsState(
      projectsModel:
          projectsModel ?? this.projectsModel,
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
    return other is ProjectsState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.projectsModel == projectsModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      projectsModel.hashCode;
}
