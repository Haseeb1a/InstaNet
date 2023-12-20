import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instanet/controller/logincontroller.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/services/auth_mehods.dart';
import 'package:instanet/view/bottom_bar/mobile_screen_layout.dart';
import 'package:instanet/view/singup_page/singup_screen.dart';
import 'package:instanet/view/widgets/text_feild_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final loginController = Provider.of<LoginController>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              TextfeildInput(
                hintText: 'enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: loginController.emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextfeildInput(
                hintText: 'enter your password',
                textInputType: TextInputType.text,
                isPass: true,
                textEditingController: loginController.passwordController,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    // loginUser;
                    loginController.loginUsers(context);
                  }
                },
                child: Container(
                  child: loginController.isloading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : const Text('log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/9679/9679133.png'),
                          radius: 18,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Phone!'),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String result = await AuthMethod().signInWithGoogle();
                      print(result);
                      if (result == 'success') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MobileScreenLayout(),
                            ));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                          radius: 22,
                          // backgroundColor: Colors.yellow,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sign with Google!'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SingupScreen(),
                          ));
                    },
                    child: Container(
                      child: const Text(
                        "sign up.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
