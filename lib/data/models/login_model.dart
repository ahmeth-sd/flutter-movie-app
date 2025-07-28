class LoginModel {
  final String token;
  final String email;
  final String name;

  LoginModel({required this.token, required this.email, required this.name});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

