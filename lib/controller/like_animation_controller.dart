import 'package:flutter/material.dart';

class LikeAnimationProvider extends ChangeNotifier {
  bool isAnimating = false;

  void startAnimation() {
    isAnimating = true;
    notifyListeners();
  }

  void endAnimation() {
    isAnimating = false;
    notifyListeners();
  }
}