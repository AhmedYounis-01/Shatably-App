import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/AI/data/models/chat_model.dart';

class ChatRepository {
  final ApiConsumer _apiConsumer;
  ChatRepository(this._apiConsumer);
  Future<ChatResponseModel> chatPrompt(ChatRequestModel prompt) async {
    try {
        final response = await _apiConsumer.post(
          "https://shatablyai.up.railway.app/chat/",
          data: prompt.toJson(),
          isFormData: true
        );
      return ChatResponseModel.fromJson(response.data);
    } on ServerFailure catch (err) {
      print('Repository error: $err');
    }
    throw Exception('Unexpected error occurred in chatPrompt');
  }
}
