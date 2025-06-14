import 'package:flutter/foundation.dart';
import 'package:shatably_app/feature/AI/data/models/image_generator_model.dart';

enum ImageGeneratorStatus { initial, loading, success, error }

extension ImageGeneratorStatesX on ImageGeneratorState {
  bool get isInitial => status == ImageGeneratorStatus.initial;
  bool get isLoading => status == ImageGeneratorStatus.loading;
  bool get isSuccess => status == ImageGeneratorStatus.success;
  bool get isError => status == ImageGeneratorStatus.error;
}

@immutable
class ImageGeneratorState {
  final ImageGeneratorStatus status;
  final String? errorMessage;
  final ImageResponseModel? imageResponseModel;
  const ImageGeneratorState({
    required this.status,
    this.errorMessage,
    this.imageResponseModel,
  });

  ImageGeneratorState copyWith({
    ImageGeneratorStatus? status,
    String? errorMessage,
    ImageResponseModel? imageResponseModel,
  }) {
    return ImageGeneratorState(
      imageResponseModel: imageResponseModel ?? this.imageResponseModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImageGeneratorState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.imageResponseModel == imageResponseModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ imageResponseModel.hashCode;
}
