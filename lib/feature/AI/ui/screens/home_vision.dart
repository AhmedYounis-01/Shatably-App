import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/AI/data/models/image_generator_model.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_cubit.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_state.dart'; // For SVG assets
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

enum ContentType { text, image }

class GeneratedContent {
  final String? text;
  final String? imageUrl;
  final ContentType type;
  final bool isLoading;
  final String? base64ImageBytes;

  GeneratedContent({
    this.text,
    this.imageUrl,
    required this.type,
    this.isLoading = false,
    this.base64ImageBytes,
  });
}

class HomeVisionScreen extends StatefulWidget {
  const HomeVisionScreen({super.key});

  @override
  State<HomeVisionScreen> createState() => _HomeVisionScreenState();
}

class _HomeVisionScreenState extends State<HomeVisionScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _descriptionController = TextEditingController();

  String? _latestUserPrompt;

  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
    _shimmerAnimation = Tween<double>(
      begin: -0.5,
      end: 1.5,
    ).animate(_shimmerController);

    _preloadAssets();
  }

  Future<void> _preloadAssets() async {}

  @override
  void dispose() {
    _descriptionController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  String _processBase64String(String base64String) {
    if (base64String.startsWith('data:image/')) {
      final commaIndex = base64String.indexOf(',');
      if (commaIndex != -1) {
        base64String = base64String.substring(commaIndex + 1);
      }
    }
    return base64String.replaceAll(RegExp(r'\s+'), '');
  }

  Uint8List? _decodeBase64Image(String base64String) {
    try {
      final processedString = _processBase64String(base64String);
      if (processedString.isEmpty) {
        print('Error decoding base64 image: Processed string is empty');
        return null;
      }
      return base64Decode(processedString);
    } catch (e) {
      print('Error decoding base64 image: $e');
      return null;
    }
  }

  void _handleGenerateVision() {
    String userDescription = _descriptionController.text.trim();

    if (userDescription.isEmpty) {
      customToast(
        context: context,
        message: "Please enter a description for your vision",
        type: ToastificationType.warning,
        icon: Icons.warning,
      );
      return;
    }

    userDescription = userDescription.replaceAll('lectrician', 'electrician');
    print('Cleaned prompt sent to API: "$userDescription"');

    context.read<ImageGeneratorCubit>().generateImage(
      ImageRequestModel(prompt: userDescription),
    );

    // Clear the text field after sending the request
    _descriptionController.clear();

    setState(() {
      _latestUserPrompt = userDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double inputBarEstimatedHeight = 70.h;

    final double contentBottomPadding =
        inputBarEstimatedHeight + keyboardHeight + 20.h;

    return Scaffold(
      backgroundColor: const Color(0XFF0A252E),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: const Color(0XFF0A252E),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Home Vision ✨",
          style: TextStyles.styleRegular(
            context,
            fontSize: 14.sp,
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
                color: Color(0XFF089ECC).withAlpha((0.46 * 255).toInt()),
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
      body: BlocConsumer<ImageGeneratorCubit, ImageGeneratorState>(
        listener: (context, state) {
          print('BlocConsumer listener triggered with status: ${state.status}');
          if (state.status == ImageGeneratorStatus.error) {
            customToast(
              context: context,
              message: 'Error: ${state.errorMessage ?? "Unknown error"}',
              type: ToastificationType.error,
              icon: Icons.error,
            );
          }
        },
        builder: (context, state) {
          GeneratedContent? currentGeneratedImage;
          if (state.status == ImageGeneratorStatus.loading) {
            currentGeneratedImage = GeneratedContent(
              type: ContentType.image,
              isLoading: true,
              text: 'Generating your vision...',
            );
          } else if (state.status == ImageGeneratorStatus.success) {
            final base64Image = state.imageResponseModel?.imageData;
            if (base64Image != null && base64Image.isNotEmpty) {
              final decodedBytes = _decodeBase64Image(base64Image);
              if (decodedBytes != null && decodedBytes.isNotEmpty) {
                currentGeneratedImage = GeneratedContent(
                  base64ImageBytes: base64Image,
                  type: ContentType.image,
                  isLoading: false,
                );
              } else {
                currentGeneratedImage = GeneratedContent(
                  text: 'Error: Invalid or empty image data received.',
                  type: ContentType.text,
                  isLoading: false,
                );
              }
            } else {
              currentGeneratedImage = GeneratedContent(
                text: 'Error: No image data found in response.',
                type: ContentType.text,
                isLoading: false,
              );
            }
          } else if (state.status == ImageGeneratorStatus.error) {
            currentGeneratedImage = GeneratedContent(
              text: 'Error: ${state.errorMessage ?? "Unknown error"}',
              type: ContentType.text,
              isLoading: false,
            );
          }

          return Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 25.w,
                    right: 25.w,
                    top: 60.h,
                    bottom: contentBottomPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 340.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF113B49),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0XFF124353),
                            width: 4.w,
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Color(0xFF113B49), Color(0xFF0A252E)],
                          ),
                        ),
                        child: _buildImageContent(currentGeneratedImage),
                      ),
                      SizedBox(height: 16.h),
                      if (currentGeneratedImage != null &&
                          !currentGeneratedImage.isLoading &&
                          currentGeneratedImage.type == ContentType.image &&
                          currentGeneratedImage.base64ImageBytes != null)
                        _buildImageActions(Colors.white, currentGeneratedImage),
                      SizedBox(height: 20.h),
                      if (_latestUserPrompt != null &&
                          _latestUserPrompt!.isNotEmpty)
                        _buildUserPromptSection(),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: keyboardHeight,
                child: _buildDescriptionInput(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageContent(GeneratedContent? content) {
    if (content?.isLoading == true) {
      return _buildLoadingShimmer(content?.text);
    } else if (content != null &&
        content.base64ImageBytes != null &&
        content.type == ContentType.image) {
      return _buildGeneratedImage(content.base64ImageBytes!);
    } else if (content != null && content.type == ContentType.text) {
      return _buildErrorMessage(message: content.text);
    } else {
      return _buildPlaceholderMessage();
    }
  }

  Widget _buildLoadingShimmer(String? message) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _shimmerAnimation.value - 0.5,
                _shimmerAnimation.value,
                _shimmerAnimation.value + 0.5,
              ],
              colors: const [
                Color(0xFF113B49),
                Color(0xFF124353),
                Color(0xFF113B49),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white.withAlpha((0.7 * 255).toInt()),
                ),
                SizedBox(height: 16.h),
                Text(
                  message ?? 'Generating...',
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 14.sp,
                    color: Colors.white.withAlpha((0.7 * 255).toInt()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGeneratedImage(String base64String) {
    final imageBytes = _decodeBase64Image(base64String);

    if (imageBytes == null || imageBytes.isEmpty) {
      return _buildErrorMessage(
        message: 'Failed to load image: Invalid or empty data.',
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.memory(
        imageBytes,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Image display error: $error');
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 40.sp),
                  SizedBox(height: 8.h),
                  Text(
                    'Image Load Error',
                    style: TextStyles.styleRegular(
                      context,
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorMessage({String? message}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.orange, size: 40.sp),
            SizedBox(height: 16.h),
            Text(
              message ?? 'An error occurred',
              textAlign: TextAlign.center,
              style: TextStyles.styleRegular(
                context,
                fontSize: 14.sp,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderMessage() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, color: Colors.blueAccent),
          const SizedBox(width: 6),
          Text(
            'Your AI-generated vision is ready to explore',
            textAlign: TextAlign.center,
            style: TextStyles.styleRegular(
              context,
              fontSize: 12.sp,
              color: Colors.blueAccent.withAlpha((0.5 * 255).toInt()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserPromptSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(AppImages.morganImage),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "You",
                  style: TextStyles.styleMedium(
                    context,
                    fontSize: 16.sp,
                    color: Colors.white.withAlpha((0.49 * 255).toInt()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 0.75.sw),
                child: Text(
                  _latestUserPrompt!,
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 32.w, bottom: 32.h),
              child: _buildImageDescriptionActions(
                Colors.white.withAlpha((0.49 * 255).toInt()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageActions(Color textColor, GeneratedContent content) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.start, // Align to start as per example
      mainAxisSize: MainAxisSize.min, // Wrap content tightly
      children: [
        _buildActionButton(
          "Copy",
          AppIcons.aiCopyIcon,
          () async {
            print('Copy image tapped');
            if (content.base64ImageBytes != null) {
              await Clipboard.setData(
                ClipboardData(text: content.base64ImageBytes!),
              );
              if (mounted) {
                customToast(
                  context: context,
                  message: "Image copied to clipboard",
                  type: ToastificationType.success,
                  icon: Icons.check,
                );
              }
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
            print('Share image tapped');
            if (content.base64ImageBytes != null) {
              customToast(
                context: context,
                message: "Share functionality not implemented yet.",
                type: ToastificationType.info,
                icon: Icons.info,
              );
            }
          },
          Colors.white,
          false,
        ),
        SizedBox(width: 10.w),
        _buildActionButton(
          "Regenerate",
          AppIcons.aiRegenerateIcon,
          () {
            if (_latestUserPrompt != null) {
              _descriptionController.text = _latestUserPrompt!;
              _handleGenerateVision();
            }
          },
          Colors.white,
          false,
        ),
      ],
    );
  }

  Widget _buildImageDescriptionActions(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionButton(
          "Edit",
          AppIcons.aiEditIcon,
          () {
            print('Edit description tapped');
            _descriptionController.text = _latestUserPrompt ?? '';
            _descriptionController.selection = TextSelection.fromPosition(
              TextPosition(offset: _descriptionController.text.length),
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
            print('Copy description tapped');
            if (_latestUserPrompt != null) {
              await Clipboard.setData(ClipboardData(text: _latestUserPrompt!));
              if (mounted) {
                customToast(
                  context: context,
                  message: "Description copied to clipboard",
                  type: ToastificationType.success,
                  icon: Icons.check,
                );
              }
            }
          },
          textColor,
          true,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    String iconPath, // Changed to iconPath to indicate it's an SVG asset path
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
            ), // Using SvgPicture.asset
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

  Widget _buildDescriptionInput(BuildContext context) {
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyles.styleRegular(
                    context,
                    fontSize: 14.sp,
                    color: Colors.white.withAlpha((0.8 * 255).toInt()),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Describe your vision...',
                    hintStyle: TextStyles.styleRegular(
                      context,
                      fontSize: 14.sp,
                      color: Colors.white.withAlpha((0.5 * 255).toInt()),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _handleGenerateVision,
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(
                      0XFF089ECC,
                    ).withAlpha((0.46 * 255).toInt()),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
