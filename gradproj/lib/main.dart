import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/views/Settings/settings.dart';
import 'package:gradproj/views/aboutUs/aboutUs.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/logIn/forgetPasswordScreens/changePassword.dart';
import 'package:gradproj/views/logIn/forgetPasswordScreens/otpScreen.dart';
import 'package:gradproj/views/logIn/logIn.dart';
import 'package:gradproj/views/signUp/signUp.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuizardCubit()),
        BlocProvider(create: (context) => AuthenticationCubit()),
      ],
      child: MaterialApp(
          routes: {
            "/home": (context) => HomeView(),
            "/login": (context) => LogIn(),
            "/signup": (context) => signUp(),
            "/aboutus": (context) => aboutUs(),
            "/subscriptions": (context) => subscriptions(),
            "/settings": (context) => Settings(),
            "/changepassword": (context) => ChangePassword(),
            "/otpscreen": (context) => OTP_Screen()
          },
          title: 'Quizard',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(backgroundColor: Colors.white),
            useMaterial3: true,
          ),
          home: await isSignedIn()
              ? FutureBuilder(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    if (snapshot.hasData) {
                      return HomeView();
                    }
                    return Center(child: CircularProgressIndicator());
                  })
              : LogIn())));
}

Future<bool> isSignedIn() async {
  return await QuizardCubit.storage.containsKey(key: "token");
}

Future<bool> getUserData() async {
  Map userData = await QuizardCubit.storage.readAll();
  QuizardCubit.USERNAME = userData["username"];
  QuizardCubit.USEREMAIL = userData["useremail"];
  QuizardCubit.USERTOKEN = userData["token"];
  return true;
}
