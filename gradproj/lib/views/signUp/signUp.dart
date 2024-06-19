import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/models/userModel.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/logIn/logIn.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        elevation: 0,
        toolbarHeight: 100,
        title: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeView()),
              );
            },
            child: Image.asset(
              'quizard'.imageAssetPng(),
              width: 100,
            ),
          ),
        ),
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
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width > 400 ? 550 : double.infinity,
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
                                    width: MediaQuery.of(context).size.width > 400 ? 450 : double.infinity,
                                    child: TextFormField(
                                      controller: usernameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a username';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.person),
                                        prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                                        labelText: 'Username',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: BorderSide(color: themeData.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width > 400 ? 450 : double.infinity,
                                    child: TextFormField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your phone number';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.phone),
                                        prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                                        labelText: 'Phone Number',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: BorderSide(color: themeData.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width > 400 ? 450 : double.infinity,
                                    child: TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your email address';
                                        } else if (!value.contains('@')) {
                                          return 'Please enter a valid email address';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                                        labelText: 'Email Address',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: BorderSide(color: themeData.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width > 400 ? 450 : double.infinity,
                                    child: TextFormField(
                                      controller: passwordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a password';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.password),
                                        prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                                        labelText: 'Password',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: BorderSide(color: themeData.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width > 400 ? 450 : double.infinity,
                                    child: TextFormField(
                                      controller: confirmPasswordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please confirm your password';
                                        } else if (value != passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.password),
                                        prefixIconColor: Color.fromARGB(255, 141, 4, 141),
                                        labelText: 'Confirm Password',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: BorderSide(color: themeData.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account? "),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LogIn()),
                                      );
                                    },
                                    child: Text("Log In"),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: BlocBuilder<QuizardCubit, States>(builder: (context, states) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width > 400 ? 450 : double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          AuthenticationCubit.GET(context)
                                              .signUp(User(emailController.text, passwordController.text,
                                                  username: usernameController.text,
                                                  phoneNumber: phoneController.text))
                                              .then((value) {
                                            QuizardCubit.USERTOKEN = value.data["token"];
                                            Navigator.pushNamed(context, "/home");
                                          }).catchError((onError) {
                                            print(onError);
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text("${onError.response.data["failure"][0]}")));
                                          });
                                        }
                                      },
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Color.fromARGB(255, 141, 4, 141),
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
