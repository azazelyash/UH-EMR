import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value, {bool informListeners = true}) {
    _isLoading = value;
    if (informListeners) notifyListeners();
  }
}
