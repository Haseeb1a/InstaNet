import 'package:flutter/material.dart';

class LikeAnimationProvider extends ChangeNotifier {
  bool isLikeAnimating = false;

  void startAnimation() {
    isLikeAnimating = true;
    notifyListeners();
  }

  void endAnimation() {
    isLikeAnimating = false;
    notifyListeners();
  }
}