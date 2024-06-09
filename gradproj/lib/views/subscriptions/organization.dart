import 'package:flutter/material.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';

class organization extends StatelessWidget {
  const organization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: quizardAppBar(context),
      drawer: screenWidth < 800 ? Drwr() : null,
      body: centeredView(
        child: Container(
          width: screenWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubscriptionCard(
                  context,
                  "BASIC",
                  "_______",
                  "10 user",
                  "10 exams/bundle",
                  "Unlimited question types",
                  "Question customization",
                  Colors.purple[800]!,
                  Colors.purple[800]!,
                  Color.fromARGB(255, 255, 225, 135),
                ),
                _buildSubscriptionCard(
                  context,
                  "PRO",
                  "_______",
                  "100 team accounts",
                  "Unlimited exams",
                  "Unlimited question types",
                  "Question customization",
                  Colors.purple[800]!,
                  Colors.purple[800]!,
                  Color.fromARGB(255, 255, 206, 59),
                ),
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
  ) {
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
          SizedBox(height: 50),
          TextButton(
            onPressed: () {},
            child: Text(
              "Purchase",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
