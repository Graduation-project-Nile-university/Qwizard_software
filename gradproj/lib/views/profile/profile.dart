import 'package:flutter/material.dart';
import 'package:gradproj/views/profile/profileEdit.dart';
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
                ProfileInfoItem(
                  label: "Name",
                  value: "", // Replace with dynamic data
                ),
                SizedBox(height: 20),
                ProfileInfoItem(
                  label: "Phone number",
                  value: "",
                ),
                SizedBox(height: 20),
                ProfileInfoItem(
                  label: "Email",
                  value: "", // Replace with dynamic data
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => profileEdit()),
                    );
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )
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
            color: Colors.black87,
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
