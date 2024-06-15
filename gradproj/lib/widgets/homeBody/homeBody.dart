import 'package:flutter/material.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/main.dart';
import 'package:gradproj/widgets/homeBody/Imagec.dart';

class homeBody extends StatelessWidget {
  const homeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("plan ${QuizardCubit.NUMBEROFGENS}");
    return FutureBuilder(
      future: QuizardCubit.storage.readAll(),
      builder: (context, ss) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "QUIZARD",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Join millions of students and tutors to effortlessly generate your exam questions instantly",
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: CarouselWithIndicatorDemo(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}