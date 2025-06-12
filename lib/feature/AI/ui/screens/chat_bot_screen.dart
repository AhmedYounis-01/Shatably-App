import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart'; // Import Dio
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

// Assuming these are defined in your project
import 'package:shatably_app/core/utils/app_images.dart';

// Define message types for clear distinction
enum MessageSender { user, bot }

// Message data model
class ChatMessage {
  final String text;
  final MessageSender sender;
  final bool isTyping;

  ChatMessage({
    required this.text,
    required this.sender,
    this.isTyping = false,
  });
}

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  // _messages list starts empty now, populated after the first user interaction
  final List<ChatMessage> _messages = [];

  bool _isBotTyping = false; // State to manage bot typing indicator
  bool _isInitialScreen =
      true; // State to manage initial welcome screen display

  // Scroll controller to automatically scroll to the bottom of the chat
  final ScrollController _scrollController = ScrollController();

  // Initialize Dio instance
  final Dio _dio = Dio();

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
          _scrollController
              .position
              .minScrollExtent, // minScrollExtent for reverse: true
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty || _isBotTyping) return;

    final userMessageText = _messageController.text;

    setState(() {
      if (_isInitialScreen) {
        _isInitialScreen =
            false; // Transition from welcome screen to chat screen

        // Add the initial conversation history here. These messages will appear once the user sends their first message.
        // Uncomment and modify this section to add your desired initial bot/user conversation.
        // _messages.add(
        //   ChatMessage(text: "Hey, what's on your mind today?", sender: MessageSender.bot),
        // );
        _messages.add(
          ChatMessage(
            text:
                "Hi, I just bought a new apartment and I'm not sure where to start with finishing it. Can you give me some advice?",
            sender: MessageSender.user,
          ),
        );
        _messages.add(
          ChatMessage(
            text:
                "Sure. Start with electrical and plumbing work to avoid rework later. Then move to flooring and wall finishes. After that, install ceilings and lighting. Finally, handle carpentry like doors, kitchen units, and wardrobes. Let me know if you'd like help booking professionals for any step.",
            sender: MessageSender.bot,
          ),
        );
      }

      _messages.add(
        ChatMessage(text: userMessageText, sender: MessageSender.user),
      );
      _messageController.clear();
      _isBotTyping = true; // Show typing indicator
      _messages.add(
        ChatMessage(text: '...', sender: MessageSender.bot, isTyping: true),
      ); // Add a typing message
    });

    _scrollToBottom(); // Scroll to show the new message and typing indicator

    _getBotResponse(userMessageText); // Call the actual API function
  }

  Future<void> _getBotResponse(String prompt) async {
    // --- START: API Integration for Bot Response ---
    // This is where you will integrate your actual chatbot API (e.g., Gemini API, your backend).

    // Define your API endpoint here.
    // Replace 'https://api.example.com/chatbot-response' with your actual backend API endpoint.
    const String apiUrl = 'https://api.example.com/chatbot-response';
    // If your backend requires an API key, uncomment and set it here.
    // String apiKey = "YOUR_API_KEY_HERE";

    try {
      // Prepare the chat history payload for your API request.
      // The structure below is an example (e.g., for Gemini API). Adjust if your API requires a different format.
      final chatHistory = [
        {
          "role": "user",
          "parts": [
            {"text": prompt},
          ],
        },
      ];

      final payload = {"contents": chatHistory};

      // --- REPLACE THIS MOCK RESPONSE WITH ACTUAL DIO.POST CALL ---
      // When your backend is ready, replace this entire 'await Future.delayed' and 'final Response' block
      // with your actual Dio.post call, similar to the commented-out structure below.
      /*
      final Response<Map<String, dynamic>> response = await _dio.post(
        apiUrl,
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // If you have an API key that goes in headers:
            // 'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      */
      // Mock Dio Response (remove this block when integrating actual API)
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay
      final Response<Map<String, dynamic>> response = Response(
        requestOptions: RequestOptions(path: apiUrl),
        data: {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text':
                        "Got it! Based on your query, here's some simulated advice. When you connect me to the actual AI, I'll provide real-time suggestions!",
                  },
                ],
              },
            },
          ],
        },
        statusCode: 200,
      );
      // End Mock Dio Response
      // --- END OF MOCK RESPONSE ---

      // Remove typing indicator immediately after receiving a response or an error.
      setState(() {
        _messages.removeWhere((msg) => msg.isTyping);
        _isBotTyping = false;
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = response.data!;

        // Parse the bot's response.
        // Adjust this parsing logic based on the actual structure of your API's successful response.
        String botText =
            "Error: Could not get response."; // Default error message
        if (result['candidates'] != null &&
            result['candidates'].isNotEmpty &&
            result['candidates'][0]['content'] != null &&
            result['candidates'][0]['content']['parts'] != null &&
            result['candidates'][0]['content']['parts'].isNotEmpty) {
          botText = result['candidates'][0]['content']['parts'][0]['text'];
        }

        setState(() {
          _messages.add(ChatMessage(text: botText, sender: MessageSender.bot));
        });
      } else {
        // Handle non-200 HTTP responses.
        setState(() {
          _messages.add(
            ChatMessage(
              text:
                  "Error: Failed to get a response from the assistant. Status code: ${response.statusCode}",
              sender: MessageSender.bot,
            ),
          );
        });
        print('Error fetching bot response: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } on DioException catch (e) {
      // Handle Dio-specific network or API errors.
      setState(() {
        _messages.removeWhere((msg) => msg.isTyping);
        _isBotTyping = false;
        String errorMessage =
            "Network Error: Could not connect to the assistant.";
        if (e.response != null) {
          errorMessage =
              "Server Error: ${e.response?.statusCode}. ${e.response?.data}";
        } else {
          errorMessage = "Network Error: ${e.message}";
        }
        _messages.add(
          ChatMessage(text: errorMessage, sender: MessageSender.bot),
        );
      });
      print('DioError during API call: $e');
    } catch (e) {
      // Catch any other unexpected errors during the API call process.
      setState(() {
        _messages.removeWhere((msg) => msg.isTyping);
        _isBotTyping = false;
        _messages.add(
          ChatMessage(
            text: "Error: Something went wrong. Please try again.",
            sender: MessageSender.bot,
          ),
        );
      });
      print('Exception during API call: $e');
    } finally {
      _scrollToBottom(); // Always scroll to bottom after bot responds or an error occurs.
    }
    // --- END: API Integration for Bot Response ---
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // Estimated height of the message input bar.
    final double inputBarEstimatedHeight = 70.h; // Scaled by ScreenUtil

    double inputFieldBottomOffset;
    double listViewContentBottomPadding;

    if (_isInitialScreen) {
      // On the initial screen:
      // If keyboard is open, input field sticks to keyboard (no extra padding).
      // If keyboard is closed, it's at the default initial screen position (140.h) from the bottom.
      inputFieldBottomOffset = keyboardHeight > 0 ? keyboardHeight : 140.h;
      // ListView is not displayed on initial screen, so this padding is not actively used.
      listViewContentBottomPadding = 0.0;
    } else {
      // Once the conversation starts:
      // Input field always sticks directly above the keyboard (no extra padding).
      inputFieldBottomOffset = keyboardHeight;
      // The ListView's bottom padding needs to account for:
      // 1. The height of the input bar.
      // 2. The height of the keyboard (if open).
      // 3. The additional 100.h scroll space requested by the user.
      listViewContentBottomPadding =
          inputBarEstimatedHeight + keyboardHeight + 100.h;
    }

    return Scaffold(
      backgroundColor: const Color(0XFF0A252E),
      // Setting resizeToAvoidBottomInset to false gives us full control over keyboard avoidance.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: const Color(0XFF0A252E), // Dark background
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
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.w),
        //   onPressed: () {
        //   },
        // ),
      ),
      body: Stack(
        // Use Stack to position the input field at the bottom
        children: [
          if (_isInitialScreen) // Display welcome screen if initial
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
          else // Display chat messages if conversation has started
            Positioned.fill(
              child: ListView.builder(
                controller: _scrollController, // Assign the scroll controller
                reverse: true, // To show latest messages at the bottom
                // Adjust padding based on input field height, keyboard inset, and additional scroll space
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 10.h,
                  bottom:
                      listViewContentBottomPadding, // Dynamically calculated bottom padding
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message =
                      _messages[_messages.length -
                          1 -
                          index]; // Display in correct order
                  return _buildMessageBubble(message, context);
                },
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom:
                inputFieldBottomOffset, // Control bottom position dynamically
            child: _buildMessageInput(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, BuildContext context) {
    final bool isUser = message.sender == MessageSender.user;
    final Color messageTextColor =
        Colors.white; // Both user and bot messages are white
    final Color nameTextColor = Colors.white.withAlpha((0.49 * 255).toInt());

    return Align(
      alignment:
          Alignment
              .centerLeft, // Both user and bot messages are aligned to the left
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 5.w,
        ), // Adjusted vertical margin
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // All text aligns to the start
          children: [
            Row(
              mainAxisSize: MainAxisSize.min, // To wrap content horizontally
              children: [
                // Avatar for both user and bot
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
                // Use ConstrainedBox to limit width
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
                        : Text(
                          message.text,
                          style: TextStyles.styleRegular(
                            context,
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
            SizedBox(height: 16.h),
            if (!message.isTyping) // Hide actions for typing indicator
              Padding(
                padding: EdgeInsets.only(left: 32.w, bottom: 32.h),
                child: _buildMessageActions(
                  isUser,
                  nameTextColor,
                ), // Use nameTextColor for actions
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageActions(bool isUser, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isUser) ...[
          // User's message actions
          _buildActionButton(
            "Edit",
            AppIcons.aiEditIcon,
            () {},
            textColor,
            true,
          ),
          SizedBox(width: 10.w),
          _buildActionButton(
            "Copy",
            AppIcons.aiCopyIcon,
            () {
              // Implement copy functionality
            },
            textColor,
            true,
          ),
        ] else ...[
          // Bot's message actions
          _buildActionButton(
            "Copy",
            AppIcons.aiCopyIcon,
            () {
              // Implement copy functionality
            },
            Colors.white,
            false,
          ),
          SizedBox(width: 10.w),
          _buildActionButton(
            "Share",
            AppIcons.aiShareIcon,
            () {},
            Colors.white,
            false,
          ),
          SizedBox(width: 10.w),
          _buildActionButton(
            "Regenerate",
            AppIcons.aiRegenerateIcon,
            () {},
            Colors.white,
            false,
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    String icon,
    VoidCallback onPressed,
    Color textColor,
    bool isUser,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ignore: deprecated_member_use
          SvgPicture.asset(icon, color: textColor),
          // Icon(icon, size: 16.sp, color: textColor),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyles.styleRegular(
              context,
              fontSize: 14.sp,
              color: isUser ? Color(0XFF776F69) : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
          gradient: LinearGradient(
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
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF113B49), Color(0xFF0A252E)],
            ),
            border: Border.all(color: const Color(0xFF124353), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  // maxLines: null,
                  // keyboardType: TextInputType.multiline,
                  style: TextStyles.styleRegular(
                    context,
                    color: Color(
                      0xFF089ECC,
                    ).withAlpha((.46 * 255).toInt()), // لون الخط
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Message Shatably Assistant.......',
                    hintStyle: TextStyles.styleRegular(
                      context,
                      color: Color(
                        0xFF089ECC,
                      ).withAlpha((.46 * 255).toInt()), // لون الخط
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _handleSendMessage,

                child: SvgPicture.asset(
                  AppIcons.addPhotoIcon,
                  width: 25.w,
                  height: 25.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
