// models/User_model.dart
// models/user_model.dart
class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final Role role; // 'buyer' or 'seller'

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  // Convert from Map
  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
      );

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}

enum Role { buyer, seller }
