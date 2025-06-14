import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/AI/data/models/image_generator_model.dart';

class ImageGeneratorRepository {
  final ApiConsumer _apiConsumer;

  ImageGeneratorRepository(this._apiConsumer);

  Future<ImageResponseModel> generateImage(ImageRequestModel prompt) async {
    try {
      final response = await _apiConsumer.post(
        "https://shatablyai.up.railway.app/image/generate",
        data: prompt.toJson(),
      );

      print('API Response: $response');

      return ImageResponseModel.fromJson(response.data);
    } on ServerFailure catch (err) {
      print('Repository error: $err');
      rethrow;
    }
  }
}
