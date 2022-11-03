// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class File {
  String? url;
  String? name;

  File({
    this.url,
    this.name,
  }) {
    name = name ?? (url == null ? null : path.basename(url!));
  }

  /// Get extension of file, ex: `".jpg"`
  String? get extension => url != null ? path.extension(url!) : null;

  /// Get mimeType of file, ex: `"image/jpeg"`
  String? get mimeType => url != null ? lookupMimeType(url!) : null;

  /// Get type of file, ex: `"image"`
  String? get type => mimeType?.split('/')[0];

  bool? get isLocal => url == null ? null : !url!.startsWith("http");

  /// Return an [Image Widget] if the file is image, else return [null]
  Widget? toWidget() => type == "image"
      ? isLocal!
          ? Image.asset(url!)
          : Image.network(url!)
      : null;

  File copyWith({
    String? url,
    String? name,
  }) {
    return File(
      url: url ?? this.url,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'name': name,
    };
  }

  factory File.fromMap(Map<String, dynamic> map) {
    return File(
      url: map['url'] != null ? map['url'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory File.fromJson(String source) => File.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'File(url: $url, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is File && other.url == url && other.name == name;
  }

  @override
  int get hashCode => url.hashCode ^ name.hashCode;
}
