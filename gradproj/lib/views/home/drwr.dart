import 'package:flutter/material.dart';
import 'package:gradproj/backend/ml_models_backend.dart';
import 'package:gradproj/views/aboutUs/aboutUs.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/logIn/logIn.dart';
import 'package:gradproj/views/signUp/signUp.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';

class Drwr extends StatelessWidget {
  const Drwr({super.key});

  
  @override
  
  Widget build(BuildContext context) {
    return 
        Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 141, 4, 141),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeView()));
              },
            ),
            ListTile(
              title: const Text('Subscriptions'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const subscriptions()));
              },
            ),
            ListTile(
              title: const Text('Test'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MLModel()));
              },
            ),
            ListTile(
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const signUp()));
              },
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const logIn()));
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => aboutUs()));
              },
            ),
          ],
        ),
      )
    ;
  }
  }