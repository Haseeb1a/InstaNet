import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instanet/controller/mobilephone_controller.dart';
import 'package:instanet/view/login_page/widgets/otp_screen.dart';
import 'package:provider/provider.dart';

class Mobilepage extends StatelessWidget {
  const Mobilepage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    // final TextEditingController numbercontroller = TextEditingController();
    final mobileController = Provider.of<MobileController>(context);

    // Country SelectedCountry = Country(
    //     phoneCode: '91',
    //     countryCode: 'IN',
    //     e164Sc: 0,
    //     geographic: true,
    //     level: 1,
    //     name: "india",
    //     example: "india",
    //     displayName: "india",
    //     displayNameNoCountryCode: "IN",
    //     e164Key: '');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: [
            
            const SizedBox(
              height: 10,
            ),
            Form(
              key: formkey,
              child: TextFormField(
                controller:mobileController.numbercontroller,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          countryListTheme: const CountryListThemeData(
                            bottomSheetHeight: 550
                          ),
                            context: context,
                            onSelect: (value) {
                             mobileController.selectChanges(value);
                            });
                      },
                      child: Text(
                        '${mobileController.SelectedCountry.flagEmoji}  +${mobileController.SelectedCountry.phoneCode} ',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  hintText: 'enter your mobile number',
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 255,
                            255)), // Set the enabled border color here
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.green), // Set the focused border color here
                  ),
                  suffixIcon:
                    
                    
                     Icon(Icons.phone,
                    color: Colors.white,size: 20,),
                    
                    
                  
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
                // inputFormatters: [LengthLimitingTextInputFormatter(10)],
                maxLength: 10,
                keyboardType: TextInputType.number,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return " Field is required 10 numbers";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  mobileController.loginWithPhone(
                                  context, mobileController.numbercontroller.text);
                }
              },
              child: Container(
                child: const Text('Confirm'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
