// models/User_model.dart
class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String role; // 'buyer' or 'seller'

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

  factory User.fromQueryRow(Map<String, dynamic> row) => User(
        id: row['user_id'] as int?,
        username: row['user_username'] as String,
        email: row['user_email'] as String,
        password: '',
        role: row['user_role'] as String,
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

  const User.empty()
      : id = null,
        username = '',
        email = '',
        password = '',
        role = '';
}
