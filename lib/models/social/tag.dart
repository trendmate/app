import 'dart:convert';

class Tag {
  final String tagId;
  final String name;

  Tag({
    required this.tagId,
    required this.name,
  });

  Tag copyWith({
    String? tagId,
    String? name,
  }) {
    return Tag(
      tagId: tagId ?? this.tagId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tagId': tagId,
      'name': name,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      tagId: map['tagId'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));

  @override
  String toString() => 'Tag(tagId: $tagId, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tag && other.tagId == tagId && other.name == name;
  }

  @override
  int get hashCode => tagId.hashCode ^ name.hashCode;
}
