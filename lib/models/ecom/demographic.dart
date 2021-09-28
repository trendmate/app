import 'dart:convert';

class Demographic {
  final String demographicId;
  final String name;
  final String gender;
  final int ageStart;
  final int ageEnd;

  Demographic({
    required this.demographicId,
    required this.name,
    required this.gender,
    required this.ageStart,
    required this.ageEnd,
  });

  Demographic copyWith({
    String? demographicId,
    String? name,
    String? gender,
    int? ageStart,
    int? ageEnd,
  }) {
    return Demographic(
      demographicId: demographicId ?? this.demographicId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      ageStart: ageStart ?? this.ageStart,
      ageEnd: ageEnd ?? this.ageEnd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'demographicId': demographicId,
      'name': name,
      'gender': gender,
      'ageStart': ageStart,
      'ageEnd': ageEnd,
    };
  }

  factory Demographic.fromMap(Map<String, dynamic> map) {
    return Demographic(
      demographicId: map['demographicId'],
      name: map['name'],
      gender: map['gender'],
      ageStart: map['ageStart'],
      ageEnd: map['ageEnd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Demographic.fromJson(String source) =>
      Demographic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Demographic(demographicId: $demographicId, name: $name, gender: $gender, ageStart: $ageStart, ageEnd: $ageEnd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Demographic &&
        other.demographicId == demographicId &&
        other.name == name &&
        other.gender == gender &&
        other.ageStart == ageStart &&
        other.ageEnd == ageEnd;
  }

  @override
  int get hashCode {
    return demographicId.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        ageStart.hashCode ^
        ageEnd.hashCode;
  }
}
