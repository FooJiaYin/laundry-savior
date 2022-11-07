// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Dormitory {
  final String id;
  final String name;
  final String imageUrl;
  final String university;
  final List<int> floors;
  const Dormitory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.university,
    required this.floors,
  });

  Dormitory copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? university,
    List<int>? floors,
  }) {
    return Dormitory(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      university: university ?? this.university,
      floors: floors ?? this.floors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'university': university,
      'floors': floors,
    };
  }

  factory Dormitory.fromMap(Map<String, dynamic> map) {
    return Dormitory(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      university: map['university'] as String,
      floors: List<int>.from((map['floors'] as List<int>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dormitory.fromJson(String source) => Dormitory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dormitory(id: $id, name: $name, imageUrl: $imageUrl, university: $university, floors: $floors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Dormitory &&
      other.id == id &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      other.university == university &&
      listEquals(other.floors, floors);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      university.hashCode ^
      floors.hashCode;
  }
}
