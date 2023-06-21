// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String name;
  DateTime birthday;
  double tokens;
  String email;

  User({
    required this.name,
    required this.birthday,
    required this.tokens,
    required this.email,
  });

  User copyWith({
    String? name,
    DateTime? birthday,
    double? tokens,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      tokens: tokens ?? this.tokens,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'birthday': birthday.toIso8601String(),
      'tokens': tokens,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      birthday: DateTime.parse(map['birthday'] as String),
      tokens: (map['tokens'] as num).toDouble(),
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, birthday: $birthday, tokens: $tokens, email: $email)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.birthday == birthday &&
        other.tokens == tokens &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        birthday.hashCode ^
        tokens.hashCode ^
        email.hashCode;
  }
}
