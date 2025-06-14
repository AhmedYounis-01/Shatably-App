import 'package:flutter/material.dart';
import 'package:shatably_app/feature/AI/data/models/chat_model.dart';

enum ChatPromptStatus { initial, loading, success, error }

extension ChatPromptStatesX on ChatPromptState {
  bool get isInitial => status == ChatPromptStatus.initial;
  bool get isLoading => status == ChatPromptStatus.loading;
  bool get isSuccess => status == ChatPromptStatus.success;
  bool get isError => status == ChatPromptStatus.error;
}

@immutable
class ChatPromptState {
  final ChatPromptStatus status;
  final String? errorMessage;
  final ChatResponseModel? chatResponseModel;
  const ChatPromptState({
    required this.status,
    this.errorMessage,
    this.chatResponseModel,
  });

  ChatPromptState copyWith({
    ChatPromptStatus? status,
    String? errorMessage,
    ChatResponseModel? chatResponseModel,
  }) {
    return ChatPromptState(
      chatResponseModel: chatResponseModel ?? this.chatResponseModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatPromptState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.chatResponseModel == chatResponseModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ chatResponseModel.hashCode;
}
