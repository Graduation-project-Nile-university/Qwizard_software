import 'package:flutter/material.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/logIn/components.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP_Screen extends StatelessWidget {
  const OTP_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "OTP",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "We sent you an OTP to your e-mail, please check it and write the OTP here to change your password.\n",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              PinCodeTextField(
                pinTheme: PinTheme(
                    selectedColor: themeData.primaryColor.withOpacity(0.5),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(20),
                    activeColor: themeData.primaryColor,
                    inactiveColor: themeData.primaryColor),
                keyboardType: TextInputType.number,
                appContext: context,
                length: 6,
                onCompleted: (value) {
                  if (value == currentOTP) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/changepassword", (context) => false,
                        arguments: ModalRoute.of(context)!.settings.arguments);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                            Text(
                              "  Wrong OTP",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )));
                  }
                },
              )
            ],
          ),
        ));
  }
}
