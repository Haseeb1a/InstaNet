import 'package:flutter/material.dart';

class AnimatioinController extends ChangeNotifier {
  bool isAnimating = false;
  late AnimationController controller;
  late Animation<double> scale;
  AnimatioinController() {
    // controller=AnimationController(vsync: this,duration: Duration(mil))
  }
  startAnmaion() {}

  changer() {
    isAnimating = true;
    notifyListeners();
  }
  changers() {
    isAnimating = false;
    notifyListeners();
  }
  
}
