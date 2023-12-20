import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instanet/controller/add_controller.dart';
import 'package:instanet/controller/animation_controller.dart';
import 'package:instanet/controller/bottombar_contoller.dart';
import 'package:instanet/controller/comment_controller.dart';
import 'package:instanet/controller/feed_controller.dart';
import 'package:instanet/controller/like_animation_controller.dart';
import 'package:instanet/controller/logincontroller.dart';
import 'package:instanet/controller/profile_controller.dart';
import 'package:instanet/controller/search_controller.dart';
import 'package:instanet/controller/user_provider.dart';
import 'package:instanet/firebase_options.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/view/auth_gates/auth_gates.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginController()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => Addcontroller()),
          ChangeNotifierProvider(create: (context) => AnimatioinController()),
          ChangeNotifierProvider(create: (context) => CommentController()),
          ChangeNotifierProvider(create: (context) => SearchControllers()),
          ChangeNotifierProvider(create: (context) => BottomController()),
          ChangeNotifierProvider(create: (context) => FeedController()),
          ChangeNotifierProvider(create: (context) => ProfileController()),
          ChangeNotifierProvider(create: (context) => LikeAnimationProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'intagram clone',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: mobileBackgroundColor,
            ),
            home: const AuthGate()));
  }
}
