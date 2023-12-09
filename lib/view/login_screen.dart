import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instanet/controller/logincontroller.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/view/widgets/text_feild_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
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
            SizedBox(
              height: 64,
            ),
            TextfeildInput(
              hintText: 'enter your email',
              textInputType: TextInputType.emailAddress,
              textEditingController: loginController.emailController,
            ),
            SizedBox(
              height: 24,
            ),
            TextfeildInput(
              hintText: 'enter your password',
              textInputType: TextInputType.text,
              isPass: true,
              textEditingController: loginController.passwordController,
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                // loginUser;
                loginController.loginUsers(context);
              },
              child: Container(
                child: loginController.isloading?Center(child: CircularProgressIndicator(
                  color: primaryColor,
                )): const Text('log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      "sign up.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
