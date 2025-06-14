import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/AI/data/models/chat_model.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_cubit.dart';
import 'package:shatably_app/feature/AI/logic/chat%20ai/chat_state.dart';
import 'package:toastification/toastification.dart';

// Chat Screen UI
enum MessageSender { user, bot }

class ChatMessage {
  final String text;
  final MessageSender sender;
  final bool isTyping;
  final String? base64Image;

  ChatMessage({
    required this.text,
    required this.sender,
    this.isTyping = false,
    this.base64Image,
  });
}

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

  String?
  _selectedImageBase64; // To hold the base64 string of the selected image
  bool _isBotTyping = false;
  bool _isInitialScreen = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

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
      _selectedImageBase64 = null; // Clear selected image after sending
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
                      return _buildMessageBubble(message, context);
                    },
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: inputFieldBottomOffset,
                child: _buildMessageInput(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, BuildContext context) {
    final bool isUser = message.sender == MessageSender.user;
    final Color nameTextColor = Colors.white.withAlpha((0.49 * 255).toInt());

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      isUser ? AppImages.morganImage : AppImages.botImage,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  isUser ? "You" : "Shatably Assistant",
                  style: TextStyles.styleMedium(
                    context,
                    fontSize: 16.sp,
                    color: nameTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 0.75.sw),
                child:
                    message.isTyping
                        ? Text(
                          message.text,
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 13.sp,
                            color: Colors.redAccent,
                          ),
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.text,
                              style: TextStyles.styleRegular(
                                context,
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                            if (message.base64Image != null)
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.memory(
                                    base64Decode(message.base64Image!),
                                    width: 150.w,
                                    height: 150.h,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Text(
                                          'Failed to load image',
                                          style: TextStyles.styleRegular(
                                            context,
                                            fontSize: 10.sp,
                                            color: Colors.red,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        ),
              ),
            ),
            SizedBox(height: 16.h),
            if (!message.isTyping)
              Padding(
                padding: EdgeInsets.only(left: 32.w, bottom: 32.h),
                child: _buildMessageActions(isUser, nameTextColor, message),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageActions(
    bool isUser,
    Color textColor,
    ChatMessage message,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isUser) ...[
          _buildActionButton(
            "Edit",
            AppIcons.aiEditIcon,
            () {
              _messageController.text = message.text;
              _messageController.selection = TextSelection.fromPosition(
                TextPosition(offset: _messageController.text.length),
              );
            },
            textColor,
            true,
          ),
          SizedBox(width: 10.w),
          _buildActionButton(
            "Copy",
            AppIcons.aiCopyIcon,
            () async {
              await Clipboard.setData(ClipboardData(text: message.text));
              if (mounted) {
                customToast(
                  context: context,
                  message: "Message copied to clipboard",
                  type: ToastificationType.success,
                  icon: Icons.check,
                );
              }
            },
            textColor,
            true,
          ),
        ] else ...[
          _buildActionButton(
            "Copy",
            AppIcons.aiCopyIcon,
            () async {
              await Clipboard.setData(ClipboardData(text: message.text));
              if (mounted) {
                customToast(
                  context: context,
                  message: "Message copied to clipboard",
                  type: ToastificationType.success,
                  icon: Icons.check,
                );
              }
            },
            Colors.white,
            false,
          ),
          SizedBox(width: 10.w),
          _buildActionButton(
            "Share",
            AppIcons.aiShareIcon,
            () {
              customToast(
                context: context,
                message: "Share functionality not implemented yet.",
                type: ToastificationType.info,
                icon: Icons.info,
              );
            },
            Colors.white,
            false,
          ),
          SizedBox(width: 10.w),
          _buildActionButton(
            "Regenerate",
            AppIcons.aiRegenerateIcon,
            () {
              if (_messages.isNotEmpty) {
                final lastUserMessage = _messages.firstWhere(
                  (msg) => msg.sender == MessageSender.user && !msg.isTyping,
                  orElse:
                      () => ChatMessage(text: '', sender: MessageSender.user),
                );
                if (lastUserMessage.text.isNotEmpty) {
                  _messageController.text = lastUserMessage.text;
                  _handleSendMessage(); // Call without image for text regeneration
                } else {
                  customToast(
                    context: context,
                    message: "No previous user message to regenerate from.",
                    type: ToastificationType.info,
                    icon: Icons.info,
                  );
                }
              }
            },
            Colors.white,
            false,
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    String iconPath,
    VoidCallback onPressed,
    Color textColor,
    bool isUser,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              width: 20.sp,
              height: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyles.styleRegular(
                context,
                fontSize: 14.sp,
                color: isUser ? const Color(0XFF776F69) : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF0E3441), Color(0xFF081D23)],
          ),
          border: Border.all(
            color: Colors.white.withAlpha((0.15 * 255).toInt()),
            width: .2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.25 * 255).toInt()),
              blurRadius: 8.2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF113B49), Color(0xFF0A252E)],
            ),
            border: Border.all(color: const Color(0xFF124353), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_selectedImageBase64 != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h, top: 4.h),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.memory(
                          base64Decode(_selectedImageBase64!),
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Image selected. Type a message...',
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 12.sp,
                            color: Colors.white.withAlpha((0.7 * 255).toInt()),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white.withAlpha((0.7 * 255).toInt()),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedImageBase64 = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 14.sp,
                        color: const Color(
                          0xFF089ECC,
                        ).withAlpha((0.46 * 255).toInt()),
                      ),
                      decoration: InputDecoration(
                        hintText:
                            _selectedImageBase64 != null
                                ? 'Add text for image...'
                                : 'Message Shatably Assistant.......',
                        hintStyle: TextStyles.styleRegular(
                          context,
                          fontSize: 14.sp,
                          color: const Color(
                            0xFF089ECC,
                          ).withAlpha((0.46 * 255).toInt()),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: SvgPicture.asset(
                      AppIcons.addPhotoIcon,
                      colorFilter: ColorFilter.mode(
                        _selectedImageBase64 != null
                            ? Colors.blueAccent
                            : const Color(0XFF33B0EE),
                        BlendMode.srcIn,
                      ),
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: _handleSendMessage,
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0XFF33B0EE),
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
