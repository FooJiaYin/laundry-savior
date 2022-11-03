import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApiResponse {
  final ResponseStatus status;

  ApiResponse(this.status);
}

class ResponseStatus {
  ResponseStatus({
    this.code = 1,
    this.identity = "",
    this.description = "",
    this.errors = const [],
  });
  final int code;
  final String identity;
  final String description;
  final List<ResponseError> errors;

  ResponseStatus copyWith({
    int? code,
    String? identity,
    String? description,
    List<ResponseError>? errors,
  }) {
    return ResponseStatus(
      code: code ?? this.code,
      identity: identity ?? this.identity,
      description: description ?? this.description,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'identity': identity,
      'description': description,
      'errors': errors.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseStatus.fromMap(Map<String, dynamic> map) {
    return ResponseStatus(
      code: map['code']?.toInt() ?? 0,
      identity: map['identity'] ?? '',
      description: map['description'] ?? '',
      errors:
          List<ResponseError>.from(map['errors']?.map(ResponseError.fromMap)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseStatus.fromJson(String source) =>
      ResponseStatus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseStatus(code: $code, identity: $identity, description: $description, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseStatus &&
        other.code == code &&
        other.identity == identity &&
        other.description == description &&
        listEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return code.hashCode ^
        identity.hashCode ^
        description.hashCode ^
        errors.hashCode;
  }
}

class ResponseError {
  final int code;
  final String identity;
  final String description;

  ResponseError(
    this.code,
    this.identity,
    this.description,
  );

  ResponseError copyWith({
    int? code,
    String? identity,
    String? description,
  }) {
    return ResponseError(
      code ?? this.code,
      identity ?? this.identity,
      description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'identity': identity,
      'description': description,
    };
  }

  factory ResponseError.fromMap(Map<String, dynamic> map) {
    return ResponseError(
      map['code']?.toInt() ?? 0,
      map['identity'] ?? '',
      map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseError.fromJson(String source) =>
      ResponseError.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResponseError(code: $code, identity: $identity, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseError &&
        other.code == code &&
        other.identity == identity &&
        other.description == description;
  }

  @override
  int get hashCode => code.hashCode ^ identity.hashCode ^ description.hashCode;
}