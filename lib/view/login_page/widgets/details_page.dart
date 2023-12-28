import 'package:flutter/material.dart';
import 'package:instanet/controller/logincontroller.dart';
import 'package:instanet/controller/user_information.dart';
import 'package:instanet/helpers/image.dart';
import 'package:instanet/view/widgets/text_feild_input.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatelessWidget {
  const UserInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<Userinfomation>(context);
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  loginController.image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(loginController.image!),
                          radius: 50,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(defaultProfile),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                          onPressed: () {
                            loginController.selectImage(context);
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
                  loginController.storeData(context);
                },
                child: Container(
                  child: loginController.isloading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text('Sing in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: Colors.blue),
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
      ),
    );
  }
}
