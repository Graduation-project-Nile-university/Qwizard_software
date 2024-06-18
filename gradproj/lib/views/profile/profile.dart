import 'package:flutter/material.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/subscriptions/subscriptions.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/bloc/cubit.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: QuizardCubit.USERTOKEN == null
            ? Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : Text("Welcome, ${QuizardCubit.USERNAME}"),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
      ),
      drawer: const Drwr(),
      body: centeredView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ProfileInfoItem(
                        label: "Name",
                        value: 
                         QuizardCubit.USERNAME != null
                        ? QuizardCubit.USERNAME.toString()
                        : 'No name available',
                      ),
                      SizedBox(height: 20),
                      ProfileInfoItem(
                        label: "Phone number",
                        value: QuizardCubit.PHONENUMBER != null
                        ? QuizardCubit.PHONENUMBER.toString()
                        : 'No phone number available',
                      ),
                      SizedBox(height: 20),
                      ProfileInfoItem(
                        label: "Email",
                        value: QuizardCubit.USEREMAIL != null
                        ? QuizardCubit.USEREMAIL.toString()
                        : 'No email available', 
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription Plan",
                        style: TextStyle(
                          color:  Color.fromARGB(255, 134, 134, 134),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        QuizardCubit.MEMBERSHIP != null
                        ? QuizardCubit.MEMBERSHIP.toString()
                        : 'No plan available',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => subscriptions()),
                          );
                        },
                        child: Text(
                          "Change plan",
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.2,
                            color: Color.fromARGB(255, 141, 4, 141),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),               
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color.fromARGB(255, 134, 134, 134),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        Divider(
          color: Color.fromARGB(255, 118, 118, 118),
          height: 30,
          thickness: 1,
        ),
      ],
    );
  }
}