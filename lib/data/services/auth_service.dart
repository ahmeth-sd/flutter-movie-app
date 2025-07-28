
import '../datasources/auth_remote_datasource.dart';
import '../models/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final _authRemote = AuthRemoteDataSourceImpl(client: http.Client());
  final _secureStorage = const FlutterSecureStorage();

  Future<LoginModel?> login(String email, String password) async {
    final loginModel = await _authRemote.login(email, password);
    await _secureStorage.write(key: 'token', value: loginModel.token);
    await _secureStorage.write(key: 'email', value: loginModel.email);
    await _secureStorage.write(key: 'name', value: loginModel.name);
    return loginModel;
  }

  Future<void> register(String email, String password, String name) async {
    await _authRemote.register(email, password, name);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  Future<void> logout() async {
    await _secureStorage.deleteAll();
  }

}