import 'dart:async';
import 'package:flutter/material.dart';
import "dart:html";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/Settings/settings.dart';
import 'package:gradproj/views/Ai/LLM.dart';
import 'package:gradproj/views/aboutUs/aboutUs.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/logIn/forgetPasswordScreens/changePassword.dart';
import 'package:gradproj/views/logIn/forgetPasswordScreens/otpScreen.dart';
import 'package:gradproj/views/logIn/logIn.dart';
import 'package:gradproj/views/profile/profile.dart';
import 'package:gradproj/views/signUp/signUp.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';
import 'package:gradproj/views/subscriptions/successedPayment.dart';
import 'package:universal_platform/universal_platform.dart';

Future<void> main() async {
  navigatedURL = Uri.base;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuizardCubit()),
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => LLMModelCubit()),
        BlocProvider(create: (context) => SubscriptionCubit())
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
            "/otpscreen": (context) => OTP_Screen(),
            "/Test": (context) => LLM(),
            "/profile": (context) => profile(),
            "/successPayment": (context) => SuccessedPayment(
                  url: navigatedURL.toString(),
                )
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
                    if (snapshot.hasData) {
                      return HomeView();
                    }
                    return Center(child: CircularProgressIndicator());
                  })
              : HomeView())));
}

Future<bool> isSignedIn() async {
  if (UniversalPlatform.isWeb) {
    return window.localStorage.containsKey("usertoken");
  }
  return await QuizardCubit.storage.containsKey(key: "usertoken");
}

Future<bool> getUserData() async {
  try {
    if (UniversalPlatform.isWeb) {
      QuizardCubit.USERNAME = window.localStorage["username"];
      QuizardCubit.USEREMAIL = window.localStorage["useremail"];
      QuizardCubit.USERTOKEN = window.localStorage["usertoken"];
      QuizardCubit.MEMBERSHIP = window.localStorage["myPlan"];
      QuizardCubit.PHONENUMBER = window.localStorage["phoneNumber"];
      QuizardCubit.NUMBEROFGENS =
          double.parse(window.localStorage["numOfGens"].toString());
    } else {
      QuizardCubit.USERNAME = await QuizardCubit.storage.read(key: "username");
      QuizardCubit.USEREMAIL =
          await QuizardCubit.storage.read(key: "useremail");
      QuizardCubit.USERTOKEN =
          await QuizardCubit.storage.read(key: "usertoken");
      QuizardCubit.MEMBERSHIP = await QuizardCubit.storage.read(key: "myPlan");
      QuizardCubit.PHONENUMBER =
          await QuizardCubit.storage.read(key: "phoneNumber");
      QuizardCubit.NUMBEROFGENS = double.parse(
          await QuizardCubit.storage.read(key: "numOfGens") as String);
    }

    // QuizardCubit.USERNAME = userData["username"];
    // QuizardCubit.USEREMAIL = userData["useremail"];
    // QuizardCubit.USERTOKEN = userData["usertoken"];
  } catch (e) {
    print(e.toString());
  }

  return true;
}
