import 'package:flutter/material.dart';
import 'package:gradproj/views/subscriptions/individual.dart';
import 'package:gradproj/views/subscriptions/organization.dart';
import 'package:gradproj/views/home/HomeView.dart';

class subscriptions extends StatelessWidget {
  const subscriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 191, 0),
              Color.fromARGB(255, 141, 4, 141),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.05,
              horizontal: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    },
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "SUBSCRIPTIONS",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            height: 0.9,
                            fontSize: screenWidth * 0.1,
                            color: Colors.purple[800],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple[800],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => individual()),
                                  );
                                },
                                child: Text(
                                  "Individuals",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple[800],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => organization()),
                                  );
                                },
                                child: Text(
                                  "Organizations",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
