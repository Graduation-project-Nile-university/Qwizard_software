import 'package:flutter/material.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/main.dart';
import 'package:lottie/lottie.dart';

class Nbuttons extends StatelessWidget {
  final String text;
  final Widget route;

  const Nbuttons({super.key, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (this.text == "Generate Exam") {
          if (!await isSignedIn()) {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                      color: Colors.amber,
                    ),
                    padding: EdgeInsets.all(20),
                    height: 300,
                    width: MediaQuery.sizeOf(context).width / 1.1,
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                        Lottie.asset("assets/alert.json", width: 100),
                                    Text(
                                      "Please create an account first to start generating exams", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                                    ),
                        Padding(
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
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
                                    style: TextStyle(
                                        color: themeData.primaryColor),
                                  ),
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: BorderSide(
                                                  width: 3,
                                                  color:
                                                      themeData.primaryColor))),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => route));
          }
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => route));
        }
      },
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
      ),
    );
  }
}
