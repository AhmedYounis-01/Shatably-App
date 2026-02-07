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
