import 'package:flutter/material.dart';
import 'package:instanet/helpers/app_colors.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('g',style: TextStyle(color: primaryColor),)),
    );
  }
}