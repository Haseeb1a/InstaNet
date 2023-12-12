import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instanet/controller/logincontroller.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:instanet/view/widgets/text_feild_input.dart';
import 'package:provider/provider.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
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
            Stack(
              children: [
                loginController.image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(loginController.image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXyq66RINPZ5mByRQDyYd7INUOstVTR23ROQ&usqp=CAU'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () {
                          loginController.selectimage();
                        },
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextfeildInput(
              hintText: 'enter your name',
              textInputType: TextInputType.emailAddress,
              textEditingController: loginController.usercontroller,
            ),
            const SizedBox(
              height: 24,
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
            TextfeildInput(
              hintText: 'enter your bio',
              textInputType: TextInputType.text,
              // isPass: true,
              textEditingController: loginController.biocontroller,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                loginController.signUpUser(context);
              },
              child: Container(
                child: loginController.isloading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sing in'),
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
                  onTap: () {},
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
    );
  }
}
