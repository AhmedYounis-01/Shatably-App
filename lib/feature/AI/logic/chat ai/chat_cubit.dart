import 'package:bloc/bloc.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/AI/data/models/chat_model.dart';
import 'package:shatably_app/feature/AI/data/repository/chat_repository.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_state.dart';

class ChatCubit extends Cubit<ChatPromptState> {
  ChatCubit(this._chatRepository)
    : super(const ChatPromptState(status: ChatPromptStatus.initial));
  final ChatRepository _chatRepository;
  Future<void> chatPrompt(ChatRequestModel prompt) async {
    emit(state.copyWith(status: ChatPromptStatus.loading));
    try {
      final response = await _chatRepository.chatPrompt(prompt);
      emit(
        state.copyWith(
          status: ChatPromptStatus.success,
          chatResponseModel: response,
        ),
      );
    } on ServerFailure catch (e) {
      emit(
        state.copyWith(status: ChatPromptStatus.error, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatPromptStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
