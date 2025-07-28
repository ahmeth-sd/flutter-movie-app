import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login(String email, String password);
  Future<void> register(String email, String password, String fullName);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://caseapi.servicelabs.tech/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print(' Login response status: ${response.statusCode}');
    print(' Login response body: ${response.body}');

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final data = decoded['data'];
      if (data == null || data is! Map<String, dynamic>) {
        throw Exception("error.invalidLoginResponse");
      }
      return LoginModel.fromJson(data);
    } else {
      final errorMessage = decoded['response']?['message'];
      if (errorMessage != null &&
          errorMessage.toString().toLowerCase().contains('not found')) {
        throw Exception("error.loginUserNotFound");
      }
      throw Exception("error.loginFailed");
    }
  }

  @override
  Future<void> register(String email, String password, String fullName) async {
    final response = await client.post(
      Uri.parse('https://caseapi.servicelabs.tech/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': fullName,
      }),
    );

    print("📡 Register response status: ${response.statusCode}");
    print("📡 Register response body: ${response.body}");

    if (response.statusCode != 200 && response.statusCode != 201) {
      final decoded = jsonDecode(response.body);
      final errorMessage = decoded['response']?['message'];

      if (errorMessage != null &&
          errorMessage.toString().toLowerCase().contains('exists')) {
        throw Exception("error.registerUserAlreadyExists");
      }
      throw Exception("error.registerFailed");
    }
  }
}

