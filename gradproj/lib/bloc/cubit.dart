import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/models/userModel.dart';

class QuizardCubit extends Cubit<States> {
  QuizardCubit() : super(InitialState());
  final String BASEURL = "https://quizard-1-g7790211.deta.app";
  static String? USERTOKEN, USERNAME, USEREMAIL, PHONENUMBER;

  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static final FlutterSecureStorage storage =
      FlutterSecureStorage(aOptions: getAndroidOptions());
}

class AuthenticationCubit extends QuizardCubit {
  static AuthenticationCubit GET(BuildContext context) =>
      BlocProvider.of(context);

  Future<Response> signUp(User userdata) async {
    print(userdata.password);
    var response = await Dio().post("$BASEURL/authentication/signup",
        data: {
          "email": userdata.email,
          "password": userdata.password,
          "username": userdata.username,
          "phoneNumber": userdata.phoneNumber
        },
        options: Options(headers: {
          "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
        }));
    print(response.data);
    if (response.statusCode == 200) {
      QuizardCubit.USEREMAIL = userdata.email;
      QuizardCubit.USERNAME = userdata.username;
      QuizardCubit.USERTOKEN = response.data["token"];

      QuizardCubit.storage.write(key: "token", value: response.data["token"]);
      QuizardCubit.storage.write(key: "username", value: userdata.username);
      QuizardCubit.storage.write(key: "useremail", value: userdata.email);
      QuizardCubit.storage
          .write(key: "phoneNumber", value: userdata.phoneNumber);
    }

    return response;
  }

  Future<Response> logIn(User userdata) async {
    print(userdata.password);

    var response = await Dio().post("$BASEURL/authentication/login",
        data: {
          "email": userdata.email,
          "password": userdata.password,
        },
        options: Options(headers: {
          "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
        }));

    if (response.statusCode == 200) {
      QuizardCubit.USEREMAIL = userdata.email;
      QuizardCubit.USERNAME = response.data["user_data"]["username"];
      QuizardCubit.USERTOKEN = response.data["token"];
      QuizardCubit.PHONENUMBER = response.data["user_data"]["phoneNumber"];

      QuizardCubit.storage.write(key: "token", value: response.data["token"]);
      QuizardCubit.storage.write(
          key: "username", value: response.data["user_data"]["username"]);
      QuizardCubit.storage.write(key: "useremail", value: userdata.email);
      QuizardCubit.storage.write(
          key: "phoneNumber", value: response.data["user_data"]["phoneNumber"]);
    }
    return response;
  }

  Future<Response> forgetPassword(String email) async {
    var response = await Dio().post("$BASEURL/authentication/forgetPassword",
        data: {
          "email": email,
        },
        options: Options(headers: {
          "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
        }));

    return response;
  }

  Future<Response> changePasssword(String email, String newPassword) async {
    var response = await Dio().post("$BASEURL/authentication/changePassword",
        data: {"email": email, "new_password": newPassword},
        options: Options(headers: {
          "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
        }));
    return response;
  }

  Future<void> signOut() async {
    await QuizardCubit.storage.deleteAll().then((value) {
      QuizardCubit.USEREMAIL = null;
      QuizardCubit.USERNAME = null;
      QuizardCubit.USERTOKEN = null;
    });
    print(await QuizardCubit.storage.containsKey(key: "token"));
  }
}
