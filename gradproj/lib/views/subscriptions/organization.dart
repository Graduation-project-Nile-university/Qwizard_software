import 'package:flutter/material.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';
// import 'package:gradproj/views/home/HomeView.dart';

class organization extends StatelessWidget {
  const organization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: navigationBar(),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
        toolbarHeight: 110,
      ),
      body: centeredView(
        child: Container(
          width: screenWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isSmallScreen) SizedBox(width: screenWidth * 0.1),
                Container(
                  width: isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.35,
                  margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 50),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 217, 1, 217),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("BASIC",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              height: 0.9,
                              fontSize: 25,
                              color: Colors.purple[800])),
                      SizedBox(height: 25),
                      Text("10 user",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 30),
                      Text("10 exams/bundle",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 30),
                      Text("Unlimited question types",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 30),
                      Text("Question customization",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 50),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Purchase",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.purple[800]),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isSmallScreen) SizedBox(width: screenWidth * 0.2),
                Container(
                  width: isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.35,
                  margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 50),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 175, 0, 175),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("PRO",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              height: 0.9,
                              fontSize: 25,
                              color: Colors.purple[800])),
                      SizedBox(height: 25),
                      Text("100 team accounts",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 30),
                      Text("Unlimited exams",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 30),
                      Text("Unlimited question types",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 30),
                      Text("Question customization",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              height: 0.9,
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 50),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Purchase",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.purple[800]),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isSmallScreen) SizedBox(width: screenWidth * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
