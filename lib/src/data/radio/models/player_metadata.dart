class PlayerMetadata {
  final String? title;
  final String? artist;

  const PlayerMetadata({
    this.title,
    this.artist,
  });

  bool get isEmpty => title == null && artist == null;
}