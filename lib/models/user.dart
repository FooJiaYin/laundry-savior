// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'file.dart';

class User {
  int id;
  File profileImage;
  String name;
  String email;
  DateTime createdTime;
  DateTime lastActive;
  User({
    required this.id,
    required this.profileImage,
    required this.name,
    required this.email,
    required this.createdTime,
    required this.lastActive,
  });

  User copyWith({
    int? id,
    File? profileImage,
    String? name,
    String? email,
    DateTime? createdTime,
    DateTime? lastActive,
  }) {
    return User(
      id: id ?? this.id,
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      email: email ?? this.email,
      createdTime: createdTime ?? this.createdTime,
      lastActive: lastActive ?? this.lastActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'profileImage': profileImage.toMap(),
      'name': name,
      'email': email,
      'createdTime': createdTime.millisecondsSinceEpoch,
      'lastActive': lastActive.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      profileImage: File.fromMap(map['profileImage'] as Map<String,dynamic>),
      name: map['name'] as String,
      email: map['email'] as String,
      createdTime: DateTime.fromMillisecondsSinceEpoch(map['createdTime'] as int),
      lastActive: DateTime.fromMillisecondsSinceEpoch(map['lastActive'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, profileImage: $profileImage, name: $name, email: $email, createdTime: $createdTime, lastActive: $lastActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.profileImage == profileImage &&
      other.name == name &&
      other.email == email &&
      other.createdTime == createdTime &&
      other.lastActive == lastActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      profileImage.hashCode ^
      name.hashCode ^
      email.hashCode ^
      createdTime.hashCode ^
      lastActive.hashCode;
  }
}
