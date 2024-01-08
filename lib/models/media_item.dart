class MediaItem {
  final String url;
  const MediaItem(this.url);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }
}
