import 'dart:convert';

class AuthToken {
  AuthToken(
    this.token,
    this.refreshToken,
  );

  final String token;
  final String refreshToken;

  AuthToken copyWith({
    String? token,
    String? refreshToken,
  }) {
    return AuthToken(
      token ?? this.token,
      refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  factory AuthToken.fromMap(Map<String, dynamic> map) {
    return AuthToken(
      map['token'] ?? '',
      map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthToken.fromJson(String source) =>
      AuthToken.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthToken(token: $token, refreshToken: $refreshToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthToken &&
        other.token == token &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => token.hashCode ^ refreshToken.hashCode;
}
