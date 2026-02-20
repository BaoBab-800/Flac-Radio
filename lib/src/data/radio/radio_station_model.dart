class RadioStationModel {
  final String id;
  final String titleKey;
  final Uri streamUrl;
  final Uri? imageUrl;

  const RadioStationModel({
    required this.id,
    required this.titleKey,
    required this.streamUrl,
    this.imageUrl,
  });
}