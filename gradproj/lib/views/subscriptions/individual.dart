import 'package:flutter/material.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubscriptionCard(
                context,
                "FREE",
                "_______",
                "1 user",
                "1 exam",
                "15 questions",
                Colors.purple[800]!,
                Colors.purple[800]!,
                Colors.white,
              ),
              _buildSubscriptionCard(
                context,
                "BASIC",
                "_______",
                "1 user",
                "5 exams/week",
                "Limited question types",
                Colors.purple[800]!,
                Colors.purple[800]!,
                Color.fromARGB(255, 255, 225, 135),
              ),
              _buildSubscriptionCard(
                context,
                "PRO",
                "_______",
                "2 user",
                "Unlimited exams",
                "Unlimited question types",
                Colors.purple[800]!,
                Colors.purple[800]!,
                Color.fromARGB(255, 255, 206, 59),
              ),
            ],
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
  ) {
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
          SizedBox(height: 50),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => individual()),
              );
            },
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
