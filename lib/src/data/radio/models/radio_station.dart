class RadioStation {
  final String id;
  final String title;
  final Uri streamUrl;
  final String? description;
  final String? imageUrl;

  const RadioStation({
    required this.id,
    required this.title,
    required this.streamUrl,
    this.description,
    this.imageUrl,
  });
}