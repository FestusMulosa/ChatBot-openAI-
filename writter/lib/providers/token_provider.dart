import 'package:flutter/material.dart';

class TokenProvider with ChangeNotifier {
  int _availableToken = 15;

  int get token => _availableToken;

  set token(int value) {
    _availableToken = value;
    notifyListeners();
  }

  void decrementToken() {
    _availableToken--;
    notifyListeners();
  }
}
