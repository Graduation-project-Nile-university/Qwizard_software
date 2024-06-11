import 'package:flutter/material.dart';
import 'package:gradproj/views/Ai/LLM.dart';
import 'package:gradproj/views/aboutUs/aboutUs.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/logIn/logIn.dart';
import 'package:gradproj/views/profile/profile.dart';
import 'package:gradproj/views/signUp/signUp.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';
import 'package:gradproj/widgets/navigationBar/Nbuttons.dart';
import 'package:gradproj/views/Ai/LLM.dart';
import 'package:gradproj/views/profile/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/main.dart';

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
              icon: Image.asset('quizard'.imageAssetPng()),
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
                  route: subscriptions(),
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
                  route: LogIn(),
                ),
                FutureBuilder(
                  future:
                      isSignedIn(), // Function to check if user is signed in
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(); // Return empty container while waiting for future
                    } else {
                      if (snapshot.data == true) {
                        return Nbuttons(
                          text: 'PROFILE',
                          route: profile(),
                        );
                      } else {
                        return SizedBox(); // Return empty container if user is not signed in
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
