import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instanet/controller/logincontroller.dart';
import 'package:instanet/firebase_options.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/view/login_screen.dart';
import 'package:instanet/view/singup_screen.dart';
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
        ChangeNotifierProvider(create: (context) => LoginController())
      ],
      child: MaterialApp(
        title: 'intagram clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
