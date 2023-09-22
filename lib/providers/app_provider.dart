import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  bool _isScanning = false;
  bool get isScanning => _isScanning;
  set isScanning(bool value) {
    _isScanning = value;
    notifyListeners();
  }
}
