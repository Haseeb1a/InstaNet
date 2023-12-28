import 'package:flutter/material.dart';
import 'package:instanet/controller/mobilephone_controller.dart';
import 'package:instanet/view/bottom_bar/mobile_screen_layout.dart';
import 'package:instanet/view/login_page/widgets/details_page.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  final String? phoneNumber;
  final String? verificationId;
  OtpScreen(
      {super.key, required this.phoneNumber, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    // final MobileControllers = Provider.of<MobileController>(context);
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    final TextEditingController otpController = TextEditingController();
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 68,
        textStyle: TextStyle(fontSize: 22, color: Colors.black),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent)));
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Varification'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(top: 40),
          child: Column(
            children: [
              Text(
                'Verfication',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  margin: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Text(
                    'Enter the code to your number',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Text(phoneNumber!,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18))),
              Form(
                key: formkey,
                child: Pinput(
                  controller: otpController,
                  length: 6,
                  defaultPinTheme: PinTheme(
                      width: 56,
                      height: 68,
                      textStyle: TextStyle(fontSize: 22, color: Colors.black),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.transparent))),
                  focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(
                              color:
                                  const Color.fromARGB(255, 255, 255, 255)))),
                  onCompleted: (pin) => debugPrint(pin),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 6) {
                      return "enter the 6 digit otp";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      if (otpController.text.isNotEmpty) {
                        verifyOtp(context, otpController.text);
                      }
                    }
                  },
                  child: Container(
                    child: const Text('verify'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        color: Colors.pink),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 void verifyOtp(BuildContext context, String userOtp) {
    final data = Provider.of<MobileController>(context, listen: false);
    data.verifyOtps(
      
      context: context,
      verifcationId: verificationId!,
      // verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        data.checkExithingUser().then(
          (value) async {
            if (value == true) {
              print('user exiting the app  yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
              // user exists in our app
              data.getDataFromFirebase().then(
                    (value) => data.saveUserDataToSP().then(
                          (value) => data.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MobileScreenLayout(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
               print('user exiting the app  oooooooooooooooooooooooooooooooooooooooooooooooo');
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInformationScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
  // void verfyOtp(BuildContext context,String userOtp){
  //   final data=Provider.of
  // }
}
