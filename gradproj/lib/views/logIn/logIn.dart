import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/models/userModel.dart';
import 'package:gradproj/views/logIn/components.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Log In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width > 400
                    ? 550
                    : double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: themeData.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width > 400
                                            ? 450
                                            : double.infinity,
                                    child: TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Email address must not be empty";
                                        }
                                        if (!value.contains("@")) {
                                          return "Email address is not valid";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        prefixIconColor:
                                            Color.fromARGB(255, 141, 4, 141),
                                        labelText: "Email Address",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: themeData.primaryColor)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width > 400
                                            ? 450
                                            : double.infinity,
                                    child: TextFormField(
                                      controller: passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password must not be empty";
                                        }
                                        if (!value.contains("@") &&
                                            !value.contains("_")) {
                                          return "password must contain a special character";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.password),
                                        prefixIconColor:
                                            Color.fromARGB(255, 141, 4, 141),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            isnotSeenPassword =
                                                !isnotSeenPassword;
                                          },
                                          icon: Icon(isnotSeenPassword
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined),
                                        ),
                                        suffixIconColor:
                                            Color.fromARGB(255, 141, 4, 141),
                                        labelText: "Password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: themeData.primaryColor)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return Scaffold(
                                          body:
                                              BlocBuilder<QuizardCubit, States>(
                                                  builder: (ctx, state) {
                                            return Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              30))),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Forget your password",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextField(
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      controller:
                                                          forgetEmailController,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon:
                                                            Icon(Icons.email),
                                                        prefixIconColor:
                                                            Color.fromARGB(255,
                                                                141, 4, 141),
                                                        labelText:
                                                            "Email Address",
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            await AuthenticationCubit
                                                                    .GET(
                                                                        context)
                                                                .forgetPassword(
                                                                    forgetEmailController
                                                                        .text)
                                                                .then((value) {
                                                              currentOTP = value
                                                                  .data["otp"];
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  "/otpscreen",
                                                                  arguments:
                                                                      forgetEmailController
                                                                          .text);
                                                            }).catchError(
                                                                    (onError) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          backgroundColor: Colors
                                                                              .red,
                                                                          content:
                                                                              Row(
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.warning,
                                                                                color: Colors.white,
                                                                              ),
                                                                              Text(
                                                                                onError,
                                                                                style: TextStyle(color: Colors.white),
                                                                              )
                                                                            ],
                                                                          )));
                                                            });
                                                          },
                                                          child:
                                                              Text("Submit")),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      });
                                },
                                child: Text("Forget your password?"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You don't have an account? "),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/signup");
                                      },
                                      child: Text("Sign up")),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: BlocBuilder<QuizardCubit, States>(
                                    builder: (context, states) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width > 400
                                            ? 450
                                            : double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        User userdata = User(
                                            emailController.text,
                                            passwordController.text);
                                        await AuthenticationCubit.GET(context)
                                            .logIn(userdata)
                                            .then((value) {
                                          Navigator.pushNamed(context, "/home");
                                        }).catchError((onError) {
                                          print(onError);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "${onError.response!.data["failure"][0]}")));
                                        });
                                      },
                                      child: const Text(
                                        "Log in",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color:
                                              Color.fromARGB(255, 141, 4, 141),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isnotSeenPassword = true;
