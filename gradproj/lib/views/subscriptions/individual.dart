import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/main.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:lottie/lottie.dart';


class individual extends StatelessWidget {
  const individual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: quizardAppBar(context),
      drawer: screenWidth < 800 ? Drwr() : null,
      body: centeredView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubscriptionCard(
                    context,
                    "FREE",
                    "_______",
                    "1 user",
                    "5 exams",
                    "15 questions",
                    Colors.purple[800]!,
                    Colors.purple[800]!,
                    Colors.white,
                    0),
                _buildSubscriptionCard(
                    context,
                    "BASIC",
                    "_______",
                    "1 user",
                    "20 exams",
                    "Limited question types",
                    Colors.purple[800]!,
                    Colors.purple[800]!,
                    Color.fromARGB(255, 255, 225, 135),
                    150),
                _buildSubscriptionCard(
                    context,
                    "PRO",
                    "_______",
                    "1 user",
                    "Unlimited exams",
                    "Unlimited question types",
                    Colors.purple[800]!,
                    Colors.purple[800]!,
                    Color.fromARGB(255, 255, 206, 59),
                    300),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      BuildContext context,
      String title,
      String line,
      String user,
      String exams,
      String questions,
      Color titleColor,
      Color lineColor,
      Color cardColor,
      double price) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 600;

    return Container(
      width: isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.3,
      margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              height: 0.9,
              fontSize: 25,
              color: titleColor,
            ),
          ),
          Text(
            line,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              height: 0.9,
              fontSize: 25,
              color: titleColor,
            ),
          ),
          SizedBox(height: 100),
          Text(
            user,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              height: 0.9,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 30),
          Text(
            exams,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              height: 0.9,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 30),
          Text(
            questions,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              height: 0.9,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "-",
            style: TextStyle(
              fontWeight: FontWeight.w100,
              height: 0.9,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 100),
          Text(
            "$price EGP",
            style: TextStyle(
              fontWeight: FontWeight.w100,
              height: 0.9,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 50),
          title != "FREE"
              ? BlocBuilder<SubscriptionCubit, States>(
                  builder: (context, state) {
                  return TextButton(
                    onPressed: () async {
                      await isSignedIn()
                          ? await SubscriptionCubit.GET(context)
                              .onlinePaying(context, price, title)
                          : showBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                    color: Colors.amber,
                                  ),
                                  padding: EdgeInsets.all(20),
                                  height: 300,
                                  width: MediaQuery.sizeOf(context).width / 1.1,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
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
                                                  Navigator.pushNamed(
                                                      context, "/signup");
                                                },
                                                child: Text(
                                                  "Sign Up",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(themeData
                                                                .primaryColor)),
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
                                                  Navigator.pushNamed(
                                                      context, "/login");
                                                },
                                                child: Text(
                                                  "Log In",
                                                  style: TextStyle(
                                                      color: themeData
                                                          .primaryColor),
                                                ),
                                                style: ButtonStyle(
                                                    shape: MaterialStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            side: BorderSide(
                                                                width: 3,
                                                                color: themeData
                                                                    .primaryColor))),
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
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
                    },
                    child: Text(
                      "Purchase",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: titleColor,
                      ),
                    ),
                  );
                })
              : SizedBox()
        ],
      ),
    );
  }
}
