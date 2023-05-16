import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:marafq/repository/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  late final AuthRepository _authenticationRepository;

  LoginViewModel() {
    _authenticationRepository = AuthRepository();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authenticationRepository.login(username, password);
      // return isSuccessed;
      // Login successful
      return true;
    } catch (e) {
      // Login failed
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
