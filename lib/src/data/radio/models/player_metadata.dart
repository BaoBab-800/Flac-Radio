class PlayerMetadata {
  final String title;

  PlayerMetadata({
    required this.title,
  });

  factory PlayerMetadata.fromJson(Map<String, dynamic> json) {
    final song = json['song'] ?? {};
    return PlayerMetadata(
      title: song['title'] ?? 'Неизвестно',
    );
  }
}