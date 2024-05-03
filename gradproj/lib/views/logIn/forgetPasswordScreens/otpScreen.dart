import 'package:flutter/material.dart';
import 'package:gradproj/views/logIn/components.dart';
import 'package:otp_text_field/otp_field.dart';

class OTP_Screen extends StatelessWidget {
  const OTP_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("OTP"),
          OTPTextField(
            spaceBetween: 10,
            width: MediaQuery.of(context).size.width,
            onCompleted: (value) {
              if (value == currentOTP) {
                Navigator.pushNamed(context, "/changepassword");
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
