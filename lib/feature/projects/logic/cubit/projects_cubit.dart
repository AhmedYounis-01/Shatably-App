import 'package:bloc/bloc.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/projects/data/repository/projects_repository.dart';
import 'package:shatably_app/feature/projects/logic/cubit/projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this._projectsRepository)
    : super(ProjectsState(status: ServicesStatus.initial));
  final ProjectsRepository _projectsRepository;
  Future<void> getProjects() async {
    emit(state.copyWith(status: ServicesStatus.loading));
    try {
      final response = await _projectsRepository.getProjects();
      emit(
        state.copyWith(status: ServicesStatus.success, projectsModel: response),
      );
    } on ServerFailure catch (e) {
      emit(
        state.copyWith(status: ServicesStatus.error, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ServicesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getProjectDetails(String projectId) async {
    emit(state.copyWith(status: ServicesStatus.loading, projectsModel: null));
    try {
      final response = await _projectsRepository.getProjectDetails(projectId);
      emit(
        state.copyWith(status: ServicesStatus.success, projectsModel: response),
      );
    } on ServerFailure catch (e) {
      emit(
        state.copyWith(status: ServicesStatus.error, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ServicesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
