import 'dart:convert';

class Media {
  final String mediaId;
  final MediaType type;
  final String url;
  final String title;

  Media({
    required this.mediaId,
    required this.type,
    required this.url,
    required this.title,
  });

  Media copyWith({
    String? mediaId,
    MediaType? type,
    String? url,
    String? title,
  }) {
    return Media(
      mediaId: mediaId ?? this.mediaId,
      type: type ?? this.type,
      url: url ?? this.url,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mediaId': mediaId,
      'type': type.toInt(),
      'url': url,
      'title': title,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      mediaId: map['mediaId'],
      type: mediaTypeFromInt(map['type']),
      url: map['url'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Media(mediaId: $mediaId, type: $type, url: $url, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media &&
        other.mediaId == mediaId &&
        other.type == type &&
        other.url == url &&
        other.title == title;
  }

  @override
  int get hashCode {
    return mediaId.hashCode ^ type.hashCode ^ url.hashCode ^ title.hashCode;
  }
}

enum MediaType { image, video }

extension MediaExtensions on MediaType {
  int toInt() {
    switch (this) {
      case MediaType.image:
        return 0;
      case MediaType.video:
        return 1;
    }
  }
}

MediaType mediaTypeFromInt(int media) {
  switch (media) {
    case 0:
      return MediaType.image;
    case 1:
      return MediaType.video;
    default:
      throw Exception("No Media Type");
  }
}
