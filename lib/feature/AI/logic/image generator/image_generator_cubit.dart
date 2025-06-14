import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/AI/data/models/image_generator_model.dart';
import 'package:shatably_app/feature/AI/data/repository/image_generator_repository.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_state.dart';

class ImageGeneratorCubit extends Cubit<ImageGeneratorState> {
  ImageGeneratorCubit(this._imageGeneratorRepository)
    : super(ImageGeneratorState(status: ImageGeneratorStatus.initial));

  final ImageGeneratorRepository _imageGeneratorRepository;

  Future<void> generateImage(ImageRequestModel prompt) async {
    try {
      emit(state.copyWith(status: ImageGeneratorStatus.loading));

      final response = await _imageGeneratorRepository.generateImage(prompt);

      print('Image generation successful');

      emit(
        state.copyWith(
          status: ImageGeneratorStatus.success,
          imageResponseModel: response,
        ),
      );
    } on ServerFailure catch (e) {
      emit(
        state.copyWith(
          status: ImageGeneratorStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
