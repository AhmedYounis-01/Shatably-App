import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/AI/data/models/chat_message.dart';
import 'package:shatably_app/feature/AI/data/models/chat_model.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_cubit.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_state.dart';
import 'package:shatably_app/feature/AI/ui/widgets/chat%20bot%20widgets/chat_message_bubble.dart';
import 'package:shatably_app/feature/AI/ui/widgets/chat%20bot%20widgets/chat_message_input.dart';
import 'package:toastification/toastification.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ImagePicker _picker = ImagePicker();

  String? _selectedImageBase64;
  bool _isBotTyping = false;
  bool _isInitialScreen = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage() {
    final userMessageText = _messageController.text.trim();

    if (userMessageText.isEmpty && _selectedImageBase64 == null) {
      customToast(
        context: context,
        message: "Please enter a message or select an image",
        type: ToastificationType.warning,
        icon: Icons.warning,
      );
      return;
    }
    if (_isBotTyping) return;

    setState(() {
      _isInitialScreen = false;

      _messages.add(
        ChatMessage(
          text: userMessageText,
          sender: MessageSender.user,
          base64Image: _selectedImageBase64,
        ),
      );
      _messageController.clear();
      _selectedImageBase64 = null;
      _isBotTyping = true;
      _messages.add(
        ChatMessage(text: '...', sender: MessageSender.bot, isTyping: true),
      );
    });

    _scrollToBottom();

    context.read<ChatCubit>().chatPrompt(
      ChatRequestModel(message: userMessageText, image: _selectedImageBase64),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _selectedImageBase64 = base64Image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double inputBarEstimatedHeight = 70.h;

    double inputFieldBottomOffset;
    double listViewContentBottomPadding;

    if (_isInitialScreen) {
      inputFieldBottomOffset = keyboardHeight > 0 ? keyboardHeight : 140.h;
      listViewContentBottomPadding = 0.0;
    } else {
      inputFieldBottomOffset = keyboardHeight;
      listViewContentBottomPadding =
          inputBarEstimatedHeight + keyboardHeight + 100.h;
    }

    return Scaffold(
      backgroundColor: const Color(0XFF0A252E),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: const Color(0XFF0A252E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Shatably Assistant 🤖",
          style: TextStyles.styleRegular(
            context,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0XFF089ECC).withAlpha((0.46 * 255).toInt()),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatPromptState>(
        listener: (context, state) {
          if (state.status == ChatPromptStatus.loading && !_isBotTyping) {
            // Already handled in _handleSendMessage
          } else {
            setState(() {
              _messages.removeWhere((msg) => msg.isTyping);
              _isBotTyping = false;
            });
            if (state.status == ChatPromptStatus.success) {
              if (state.chatResponseModel != null &&
                  state.chatResponseModel!.response.isNotEmpty) {
                setState(() {
                  _messages.add(
                    ChatMessage(
                      text: state.chatResponseModel!.response,
                      sender: MessageSender.bot,
                    ),
                  );
                });
              }
              _scrollToBottom();
            } else if (state.status == ChatPromptStatus.error) {
              customToast(
                context: context,
                message: 'Error: ${state.errorMessage ?? "Unknown error"}',
                type: ToastificationType.error,
                icon: Icons.error,
              );
              _scrollToBottom();
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (_isInitialScreen)
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(top: 190.h),
                    child: Text(
                      "Hey, what's on your mind today?",
                      textAlign: TextAlign.center,
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              else
                Positioned.fill(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      top: 10.h,
                      bottom: listViewContentBottomPadding,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[_messages.length - 1 - index];
                      return ChatMessageBubble(
                        message: message,
                        onEdit: () {
                          _messageController.text = message.text;
                          _messageController
                              .selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: _messageController.text.length,
                            ),
                          );
                        },
                        onCopy: () async {
                          await Clipboard.setData(
                            ClipboardData(text: message.text),
                          );
                          if (mounted) {
                            customToast(
                              context: context,
                              message: "Message copied to clipboard",
                              type: ToastificationType.success,
                              icon: Icons.check,
                            );
                          }
                        },
                        onShare: () {
                          customToast(
                            context: context,
                            message: "Share functionality not implemented yet.",
                            type: ToastificationType.info,
                            icon: Icons.info,
                          );
                        },
                        onRegenerate: () {
                          if (_messages.isNotEmpty) {
                            final lastUserMessage = _messages.firstWhere(
                              (msg) =>
                                  msg.sender == MessageSender.user &&
                                  !msg.isTyping,
                              orElse:
                                  () => ChatMessage(
                                    text: '',
                                    sender: MessageSender.user,
                                  ),
                            );
                            if (lastUserMessage.text.isNotEmpty) {
                              _messageController.text = lastUserMessage.text;
                              _handleSendMessage();
                            } else {
                              customToast(
                                context: context,
                                message:
                                    "No previous user message to regenerate from.",
                                type: ToastificationType.info,
                                icon: Icons.info,
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: inputFieldBottomOffset,
                child: ChatMessageInput(
                  controller: _messageController,
                  selectedImageBase64: _selectedImageBase64,
                  onPickImage: _pickImage,
                  onSendMessage: _handleSendMessage,
                  onRemoveImage: () {
                    setState(() {
                      _selectedImageBase64 = null;
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
