import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/main.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';

class organization extends StatelessWidget {
  const organization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: quizardAppBar(context),
      drawer: screenWidth < 800 ? const Drwr() : null,
      body: centeredView(
        child: SizedBox(
          width: screenWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubscriptionCard(
                    context,
                    "Q-BASIC",
                    "_______",
                    "10 users",
                    "100 exams",
                    "Unlimited question types",
                    "Question customization",
                    Colors.purple[800]!,
                    Colors.purple[800]!,
                    Color.fromARGB(255, 255, 225, 135),
                    650),
                _buildSubscriptionCard(
                    context,
                    "Q-PRO",
                    "_______",
                    "100 team accounts",
                    "Unlimited exams",
                    "Unlimited question types",
                    "Question customization",
                    Colors.purple[800]!,
                    Colors.purple[800]!,
                    Color.fromARGB(255, 255, 206, 59),
                    1000),
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
      String users,
      String exams,
      String questionTypes,
      String customization,
      Color titleColor,
      Color lineColor,
      Color cardColor,
      double price) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 600;

    return Container(
      width: isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.35,
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
            users,
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
            questionTypes,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              height: 0.9,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 30),
          Text(
            customization,
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
          BlocBuilder<SubscriptionCubit, States>(builder: (context, state) {
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
                              color: themeData.primaryColor,
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
                                Text(
                                  "Please Create an account at the first to start exploring our subscription plans",
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                            Navigator.pushNamed(
                                                context, "/login");
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
                                                          BorderRadius.circular(
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
        ],
      ),
    );
  }
}
