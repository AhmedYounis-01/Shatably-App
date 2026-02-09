import 'package:bloc/bloc.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/maintenance%20work/data/repository/maintenance_work_repository.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_state.dart';

class MaintenanceWorkCubit extends Cubit<MaintenanceWorkState> {
  MaintenanceWorkCubit(this._maintenanceWorkRepository)
    : super(MaintenanceWorkState(status: ServicesStatus.initial));

  final MaintenanceWorkRepository _maintenanceWorkRepository;

  Future<void> getMaintenanceWork({required String id}) async {
    emit(state.copyWith(status: ServicesStatus.loading));
    try {
      final response = await _maintenanceWorkRepository
          .getMaintenanceWorkProducts(id);

      emit(
        state.copyWith(
          status: ServicesStatus.success,
          maintenanceServiceModel: response,
        ),
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
