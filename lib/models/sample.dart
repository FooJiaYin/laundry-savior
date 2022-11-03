// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:collection/collection.dart';

import 'user.dart';

class SampleData {
  String name;
  User user;
  DateTime createdTime;
  String? description;
  List<String> tags;
  SampleData({
    required this.name,
    required this.user,
    required this.createdTime,
    this.description,
    required this.tags,
  });

  SampleData copyWith({
    String? name,
    User? user,
    DateTime? createdTime,
    String? description,
    List<String>? tags,
  }) {
    return SampleData(
      name: name ?? this.name,
      user: user ?? this.user,
      createdTime: createdTime ?? this.createdTime,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'user': user.toMap(),
      'createdTime': createdTime.millisecondsSinceEpoch,
      'description': description,
      'tags': tags,
    };
  }

  factory SampleData.fromMap(Map<String, dynamic> map) {
    return SampleData(
      name: map['name'] as String,
      user: User.fromMap(map['user'] as Map<String,dynamic>),
      createdTime: DateTime.fromMillisecondsSinceEpoch(map['createdTime'] as int),
      description: map['description'] != null ? map['description'] as String : null,
      tags: List<String>.from(map['tags'] as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SampleData.fromJson(String source) => SampleData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SampleData(name: $name, user: $user, createdTime: $createdTime, description: $description, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is SampleData &&
      other.name == name &&
      other.user == user &&
      other.createdTime == createdTime &&
      other.description == description &&
      listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      user.hashCode ^
      createdTime.hashCode ^
      description.hashCode ^
      tags.hashCode;
  }
}
