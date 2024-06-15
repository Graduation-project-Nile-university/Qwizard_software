import 'package:flutter/material.dart';
import 'package:gradproj/components/shared.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';

class profileEdit extends StatelessWidget {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: QuizardCubit.USERTOKEN == null
            ? Text(
                "Edit Profile",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            : Text("Welcome, ${QuizardCubit.USERNAME}"),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
      ),
      drawer: const Drwr(),
      body: centeredView(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                ProfileTextField(labelText: "Name", placeholder: "Full name"),
                SizedBox(height: 20),
                ProfileTextField(
                    labelText: "Phone number", placeholder: "0123456789"),
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back without saving changes
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Color.fromARGB(255, 141, 4, 141),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Profile updated successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final String placeholder;

  const ProfileTextField({
    Key? key,
    required this.labelText,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: placeholder,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
