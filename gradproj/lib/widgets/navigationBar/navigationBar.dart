import 'package:flutter/material.dart';
import 'package:gradproj/backend/ml_models_backend.dart';
import 'package:gradproj/views/aboutUs/aboutUs.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/logIn/logIn.dart';
import 'package:gradproj/views/signUp/signUp.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';
import 'package:gradproj/widgets/navigationBar/Nbuttons.dart';

class navigationBar extends StatelessWidget {
  const navigationBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 100.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
              icon: Image.asset('assets/logo.png'),
            ),
            SizedBox(width: 20.0),
            Row(
              children: [
                Nbuttons(
                  text: 'SUBSCRIPTIONS',
                  route: subscriptions(),
                ),
                SizedBox(width: 10.0),
                Nbuttons(
                  text: 'Test',
                  route: MLModel(),
                ),
                SizedBox(width: 10.0),
                Nbuttons(
                  text: 'ABOUT US',
                  route: aboutUs(),
                ),
                SizedBox(width: 10.0),
                Nbuttons(
                  text: 'SIGN UP',
                  route: signUp(),
                ),
                SizedBox(width: 10.0),
                Nbuttons(
                  text: 'LOG IN',
                  route: logIn(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
