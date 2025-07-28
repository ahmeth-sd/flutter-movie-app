import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/models/login_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthViewModel(this._authService);

  // Text controllerlar
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  // Şifre gizleme
  bool _obscure1 = true;
  bool get obscure1 => _obscure1;
  void toggleObscure1() {
    _obscure1 = !_obscure1;
    notifyListeners();
  }

  bool _obscure2 = true;
  bool get obscure2 => _obscure2;
  void toggleObscure2() {
    _obscure2 = !_obscure2;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscure1 = !_obscure1;
    notifyListeners();
  }

  bool get obscurePassword => _obscure1;

  // Kullanıcı sözleşmesi
  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;
  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  // Auth durumları
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LoginModel? _loginModel;
  LoginModel? get loginModel => _loginModel;

  // Kullanıcı adı durumu
  String? _userName;
  String? get userName => _userName;
  bool _isUserNameLoading = false;
  bool get isUserNameLoading => _isUserNameLoading;

  Future<void> login() async {
    _setLoading(true);
    try {
      _loginModel = await _authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // Token'ı güvenli şekilde sakla
      if (_loginModel?.token != null) {
        await _secureStorage.write(key: 'token', value: _loginModel!.token);
      }
      _errorMessage = null;
      _userName = _loginModel?.name;
    } catch (e) {
      _errorMessage = 'Giriş başarısız: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register() async {
    _setLoading(true);
    try {
      await _authService.register(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Kayıt başarısız: $e';
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    repeatPasswordController.clear();
  }

  Future<void> fetchUserName() async {
    _isUserNameLoading = true;
    notifyListeners();
    // Token ile kullanıcı adı alınacaksa burada eklenir, şimdilik loginModel'den alınıyor
    _userName = _loginModel?.name ?? 'Kullanıcı';
    _isUserNameLoading = false;
    notifyListeners();
  }
}
