import 'package:flutter/material.dart';
import 'package:gradproj/backend/ml_models_backend.dart';
import 'package:gradproj/views/aboutUs/aboutUs.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/logIn/logIn.dart';
import 'package:gradproj/views/signUp/signUp.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';
import 'package:gradproj/widgets/navigationBar/Nbuttons.dart';

class navigationBar extends StatelessWidget {
  const navigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeView()));
              },
              icon: Image.asset('assets/logo.png'),
            ),
          ),
          const SizedBox(
            width: 120,
          ),
          Container(
            child: const Nbuttons(text: 'SUBSCRIPTIONS',route: subscriptions()),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            child: const Nbuttons(text: 'Test',route: MLModel()),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            child:  Nbuttons(text: 'ABOUT US',route: aboutUs())
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            child: const Nbuttons(text: 'SIGN UP',route: signUp()
          ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            child: const Nbuttons(text: 'LOG IN',route: logIn()
          ),
          )
        ],
      ),
    );
  }
}
