import 'package:flutter/material.dart';

class BottomController extends ChangeNotifier {
  int pages = 0;
  late PageController pageController;

  void navigationTapped(int page) {
    
    //Animating Page
     pageController.jumpToPage(page);
     pageController.dispose();
  }

  void onPageChanged(int page) {
    // setState(() {
    pages = page;
    notifyListeners();
    // });
  }

  BottomController() {
    pageController = PageController();
    
  }
}
