import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instanet/controller/bottombar_contoller.dart';
import 'package:instanet/controller/user_provider.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/helpers/global_variable.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomcontroller = Provider.of<BottomController>(context);
      Provider.of<UserProvider>(context, listen: false).refreshUser();
    return Scaffold(
      body: PageView(
        controller:bottomcontroller. pageController,
        onPageChanged:bottomcontroller.onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (bottomcontroller.pages == 0) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (bottomcontroller.pages == 1) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: (bottomcontroller.pages == 2) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: (bottomcontroller.pages == 3) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (bottomcontroller.pages == 4) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: bottomcontroller.navigationTapped,
        currentIndex: bottomcontroller.pages,
      ),
    );
  }
}
