import 'package:flutter/material.dart';

class homeBody extends StatelessWidget {
  const homeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              vertical: 20, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  " QUIZARD",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      height: 0.9,
                      fontSize: 80,
                      color: Colors.purple[800]),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                    "      Join millions of students and tutors to effortlessly generate your exam questions instantly",
                    style: TextStyle(
                        fontSize: 17, height: 1.7, color: Colors.purple[800])),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
