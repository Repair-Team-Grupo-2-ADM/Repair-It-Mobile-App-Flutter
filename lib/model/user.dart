import 'dart:convert';

User UserFromJson(String str) => User.fromJson(json.decode(str));

class User {
  int id;
  String email;
  String username;
  String role;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        id: parsedJson['id'],
        email: parsedJson['email'],
        username: parsedJson['username'],
        role: parsedJson['role']);
  }
}
