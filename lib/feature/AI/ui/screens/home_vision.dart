import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/widgets/custom_toast.dart';
import 'package:shatably_app/feature/AI/data/models/generated_content.dart';
import 'package:shatably_app/feature/AI/data/models/image_generator_model.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_cubit.dart';
import 'package:shatably_app/feature/AI/logic/image%20generator/image_generator_state.dart';
import 'package:flutter/services.dart';
import 'package:shatably_app/feature/AI/ui/widgets/home%20vision%20widgets/vision_description_input.dart';
import 'package:shatably_app/feature/AI/ui/widgets/home%20vision%20widgets/vision_image_actions.dart';
import 'package:shatably_app/feature/AI/ui/widgets/home%20vision%20widgets/vision_image_content.dart';
import 'package:shatably_app/feature/AI/ui/widgets/home%20vision%20widgets/vision_user_prompt_section.dart';
import 'package:toastification/toastification.dart';

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
  }

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
                        child: VisionImageContent(
                          content: currentGeneratedImage,
                          shimmerAnimation: _shimmerAnimation,
                          decodeBase64Image: _decodeBase64Image,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (currentGeneratedImage != null &&
                          !currentGeneratedImage.isLoading &&
                          currentGeneratedImage.type == ContentType.image &&
                          currentGeneratedImage.base64ImageBytes != null)
                        VisionImageActions(
                          content: currentGeneratedImage,
                          onRegenerate: () {
                            if (_latestUserPrompt != null) {
                              _descriptionController.text = _latestUserPrompt!;
                              _handleGenerateVision();
                            }
                          },
                        ),
                      SizedBox(height: 20.h),
                      if (_latestUserPrompt != null &&
                          _latestUserPrompt!.isNotEmpty)
                        VisionUserPromptSection(
                          latestUserPrompt: _latestUserPrompt!,
                          onEdit: () {
                            _descriptionController.text =
                                _latestUserPrompt ?? '';
                            _descriptionController
                                .selection = TextSelection.fromPosition(
                              TextPosition(
                                offset: _descriptionController.text.length,
                              ),
                            );
                          },
                          onCopy: () async {
                            if (_latestUserPrompt != null) {
                              await Clipboard.setData(
                                ClipboardData(text: _latestUserPrompt!),
                              );
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
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: keyboardHeight,
                child: VisionDescriptionInput(
                  controller: _descriptionController,
                  onGenerate: _handleGenerateVision,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
