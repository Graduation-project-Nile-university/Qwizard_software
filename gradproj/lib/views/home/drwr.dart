import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/main.dart';

class Drwr extends StatelessWidget {
  const Drwr({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.asset("assets/logo.PNG")),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: themeData.primaryColor,
                      ),
                      const Text('  Home'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.subscriptions,
                        color: themeData.primaryColor,
                      ),
                      const Text('  Subscriptions'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/subscriptions");
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: themeData.primaryColor,
                      ),
                      const Text('  About Us'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/aboutus");
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: themeData.primaryColor,
                      ),
                      const Text('  Settings'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/settings");
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.generating_tokens,
                        color: themeData.primaryColor,
                      ),
                      const Text('  Test'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/Test");
                  },
                ),
                FutureBuilder(
                    future: isSignedIn(),
                    builder: (context, ss) {
                      if (ss.data == true) {}
                      return Container();
                    })
              ],
            ),
          ),
          FutureBuilder(
              future: isSignedIn(),
              builder: (context, ss) {
                if (ss.hasData) {
                  if (ss.data == false) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/signup");
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      themeData.primaryColor)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(color: themeData.primaryColor),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              width: 3,
                                              color: themeData.primaryColor))),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return BlocBuilder<QuizardCubit, States>(
                        builder: (context, state) {
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Icon(Icons.person),
                                const Text('  Profile'),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, "/profile");
                            },
                          ),
                          ListTile(
                            title: const Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.red,
                                ),
                                Text(
                                  '  Sign Out',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            onTap: () async {
                              await AuthenticationCubit.GET(context)
                                  .signOut()
                                  .then((value) =>
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, "/login", (route) => false))
                                  .catchError((onError) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("${onError}"),
                                  backgroundColor: Colors.red,
                                ));
                              });
                            },
                          ),
                        ],
                      );
                    });
                  }
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
