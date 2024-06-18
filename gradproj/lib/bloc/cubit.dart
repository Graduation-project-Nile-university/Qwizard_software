import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as ss;
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/models/userModel.dart';
import 'package:gradproj/views/Ai/components.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';
import "dart:html";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class QuizardCubit extends Cubit<States> {
  QuizardCubit() : super(InitialState());
  static String? USERTOKEN, USERNAME, USEREMAIL, PHONENUMBER, MEMBERSHIP;
  static double NUMBEROFGENS = 0;

  static ss.AndroidOptions getAndroidOptions() => const ss.AndroidOptions();
  static ss.FlutterSecureStorage storage =
      ss.FlutterSecureStorage(aOptions: getAndroidOptions());
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
      QuizardCubit.MEMBERSHIP = response.data["userData"]["membershipPlan"];
      QuizardCubit.NUMBEROFGENS = response.data["userData"]["numOfGens"];

      if (UniversalPlatform.isWeb) {
        window.localStorage.addEntries({
          "usertoken": response.data["token"].toString(),
          "myPlan": response.data["userData"]["membershipPlan"].toString(),
          "username": userdata.username.toString(),
          "useremail": userdata.email.toString(),
          "phoneNumber": userdata.phoneNumber.toString(),
          "numOfGens": response.data["userData"]["numOfGens"].toString()
        }.entries);
        print("Data added to web");
      } else {
        QuizardCubit.storage
            .write(key: "usertoken", value: response.data["token"]);
        QuizardCubit.storage.write(
            key: "myPlan", value: response.data["userData"]["membershipPlan"]);
        QuizardCubit.storage.write(key: "username", value: userdata.username);
        QuizardCubit.storage.write(key: "useremail", value: userdata.email);
        QuizardCubit.storage
            .write(key: "phoneNumber", value: userdata.phoneNumber);
        QuizardCubit.storage.write(
            key: "numOfGens", value: response.data["userData"]["numOfGens"]);
      }
    }

    return response;
  }

  Future<Response> logIn(User userdata) async {
    var response = await Dio().post(
      "$BASEURL/authentication/login",
      data: {
        "email": userdata.email,
        "password": userdata.password,
      },
    );
    print(response);
    if (response.statusCode == 200) {
      QuizardCubit.USEREMAIL = userdata.email;
      QuizardCubit.USERNAME = response.data["user_data"]["username"];
      QuizardCubit.USERTOKEN = response.data["token"];
      QuizardCubit.PHONENUMBER = response.data["user_data"]["phoneNumber"];
      QuizardCubit.MEMBERSHIP = response.data["user_data"]["membershipPlan"];
      QuizardCubit.NUMBEROFGENS = response.data["user_data"]["numOfGens"];

      if (UniversalPlatform.isWeb) {
        window.localStorage.addEntries({
          "numOfGens": response.data["user_data"]["numOfGens"].toString(),
          "usertoken": response.data["token"].toString(),
          "myPlan": response.data["user_data"]["membershipPlan"].toString(),
          "username": response.data["user_data"]["username"].toString(),
          "useremail": userdata.email.toString(),
          "phoneNumber": response.data["user_data"]["phoneNumber"].toString()
        }.entries);
      } else {
        QuizardCubit.storage
            .write(key: "usertoken", value: response.data["token"]);
        QuizardCubit.storage.write(
            key: "myPlan", value: response.data["user_data"]["membershipPlan"]);
        QuizardCubit.storage.write(
            key: "username", value: response.data["user_data"]["username"]);
        QuizardCubit.storage.write(key: "useremail", value: userdata.email);
        QuizardCubit.storage.write(
            key: "phoneNumber",
            value: response.data["user_data"]["phoneNumber"]);
        QuizardCubit.storage.write(
            key: "numOfGens", value: response.data["userData"]["numOfGens"]);
      }
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
    if (UniversalPlatform.isWeb) {
      window.localStorage.clear();
    } else {
      await QuizardCubit.storage.deleteAll().then((value) {
        QuizardCubit.USEREMAIL = null;
        QuizardCubit.USERNAME = null;
        QuizardCubit.USERTOKEN = null;
        QuizardCubit.MEMBERSHIP = null;
        QuizardCubit.PHONENUMBER = null;
        QuizardCubit.NUMBEROFGENS = 5;
      });
      print(await QuizardCubit.storage.containsKey(key: "usertoken"));
    }
  }
}

class LLMModelCubit extends Cubit<States> {
  LLMModelCubit() : super(InitialState());
  static LLMModelCubit GET(BuildContext context) => BlocProvider.of(context);

  Future<void> pickFile() async {
    isLoading = true;
    emit(UpdateLoading());

    var result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      pickedFileBytes = result;
      isPicked = true;
      isGenerated = false;
    }

    isLoading = false;
    emit(UpdateLoading());
  }

  Future<Response> generateQuizNow(
      Uint8List pdfFileBytes, String fileName) async {
    isGenerating = true;
    emit(UpdateLoading());
    var formData = FormData.fromMap({
      'pdf': MultipartFile.fromBytes(pdfFileBytes, filename: fileName),
    });
    Response res = await Dio().post("$BASEURL/generateExam2",
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
        }));
    if (res.statusCode == 200) isGenerated = true;
    response = res;

    isGenerating = false;
    emit(UpdateLoading());

    return res;
  }

  Future downloadPDF(String exam, String title) async {
    exam = exam.replaceAll(RegExp(r'[^A-Za-z0-9().,;:?]'), ' ');
    print(exam);
    var pdf = pw.Document();
    var image = await rootBundle.load("quizard".imageAssetPng());
    var assetImageBytes = image.buffer.asUint8List();

    await Dio()
        .post("$BASEURL/updateNumOfGens",
            data: {
              "email": QuizardCubit.USEREMAIL,
              "text": exam,
              "title": title,
            },
            options: Options(headers: {
              "email": QuizardCubit.USEREMAIL,
              "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
            }))
        .then((onValue) async {
      QuizardCubit.NUMBEROFGENS -= 1;
      window.localStorage["numOfGens"] = QuizardCubit.NUMBEROFGENS.toString();
      QuizardCubit.storage
          .write(key: "numOfGens", value: QuizardCubit.NUMBEROFGENS.toString());
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(pw.MemoryImage(assetImageBytes), width: 100),
                      pw.Text("Generated Exam"),
                      pw.SizedBox()
                    ]),
                pw.Divider(),
                pw.Center(child: pw.Text("""$exam"""))
              ],
            );
          }));
      var savedFile = await pdf.save();
      List<int> fileInts = List.from(savedFile);
      AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
        ..setAttribute(
            "download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
        ..click();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future get UserHistory async {
    Response response = await Dio().get(
        "$BASEURL/${QuizardCubit.USEREMAIL}/getUserHistory",
        options: Options(headers: {
          "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
        }));
    return response;
  }
}

class SubscriptionCubit extends Cubit<States> {
  SubscriptionCubit() : super(InitialState());
  static SubscriptionCubit GET(context) => BlocProvider.of(context);

  Future onlinePaying(
      BuildContext context, double price, String membershipPlan) async {
    String token = "";
    String orderID = "";
    String time = DateTime.now().toString();
    await Dio().post("https://accept.paymob.com/api/auth/tokens", data: {
      "api_key":
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0Rrd01qVTFMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkubGQwSHBPeS1UdjJkQ1V1OEQyU1F1RTZGaDkwQ2hsZjJlYXZxdnF2dGJ6X2lCcTF3YkZpOU85R3FzWThlYWhWNkZma1JCLW5YTy1QWnQ3aTVkeVR5bHc="
    }).then((value) => token = value.data["token"]);
    await Dio()
        .post("https://accept.paymob.com/api/ecommerce/orders", data: {
          "auth_token": "$token",
          "delivery_needed": "false",
          "amount_cents": "${price * 100 * 30.90}",
          "currency": "EGP",
          "merchant_order_id":
              "${QuizardCubit.USEREMAIL} , ${membershipPlan.trim()} , $time",
          "items": [
            {
              "name": "$membershipPlan",
              "amount_cents": "${price * 100 * 30.90}",
              "description": "IYP design ",
              "quantity": "1"
            }
          ]
        })
        .then((value) => orderID = value.data["id"].toString())
        .catchError((onError) => print(onError.response.data));
    print("HERE2");
    print(orderID);
    await Dio()
        .post("https://accept.paymob.com/api/acceptance/payment_keys", data: {
      "auth_token": "$token",
      "amount_cents": "${price * 100}",
      "expiration": 6600,
      "order_id": "$orderID",
      "billing_data": {
        "apartment": "NA",
        "email": "${QuizardCubit.USEREMAIL}",
        "first_name": "${QuizardCubit.USEREMAIL}",
        "building": "NA",
        "phone_number": "+20${QuizardCubit.PHONENUMBER}",
        "shipping_method": "PKG",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": "${QuizardCubit.USERNAME}",
        "state": "NA",
        "street": "NA",
        "floor": "NA"
      },
      "currency": "EGP",
      "integration_id": 4160709,
      "lock_order_when_paid": "true"
    }).then((value) async {
      print(value.data["token"]);
      await launchUrl(
          Uri.parse(
              "https://accept.paymobsolutions.com/api/acceptance/iframes/784851?payment_token=${value.data["token"]}"),
          webOnlyWindowName: "_self");
    }).catchError((onError) => print(onError.response.data));
  }

  Future successPayment(bool isSuccess, String email, String plan) async {
    if (isSuccess) {
      Response response = await Dio().post("$BASEURL/successPayment",
          options: Options(headers: {
            "X-API-Key": "a0KGjop74nos_4KVRhNwV4dod4cv3C7C83Q32bDXNhsAA"
          }),
          data: {"email": email, "plan": plan});
      if (response.statusCode == 200) {
        window.localStorage["myPlan"] = plan.trim();
        window.localStorage["numOfGens"] =
            response.data["numOfGens"].toString();
        QuizardCubit.storage.write(
            key: "numOfGens", value: response.data["numOfGens"].toString());
        QuizardCubit.storage.write(key: "myPlan", value: plan.trim());
        QuizardCubit.MEMBERSHIP = plan.trim();
        QuizardCubit.NUMBEROFGENS = response.data["numOfGens"];
      }
      return response;
    } else {
      return true;
    }
  }
}
