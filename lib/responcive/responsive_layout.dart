// import 'package:flutter/material.dart';
// import 'package:instanet/controller/user_provider.dart';
// import 'package:provider/provider.dart';

// class ResponsiveLayout extends StatelessWidget {
//   final Widget mobileScreenLayout;
 
//   const ResponsiveLayout({
//     Key? key,
//     required this.mobileScreenLayout,

//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<UserProvider>(context, listen: false).refreshUser();
//     return LayoutBuilder(builder: (context, constraints) {
//       return mobileScreenLayout;
//     });
//   }
// }
