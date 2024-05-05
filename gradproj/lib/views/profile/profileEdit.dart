import 'package:flutter/material.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/views/profile/profile.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';

class profileEdit extends StatelessWidget {
  bool isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: QuizardCubit.USERTOKEN == null
            ? Text(
                "Edit profile",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            : Text("Welcome, ${QuizardCubit.USERNAME}"),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
      ),
      drawer: const Drwr(),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              buildTextField("Name", "   Full name", false),
              buildTextField("Phone number", "   0123456789", false),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => profile()),
                      );
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      primary: Color.fromARGB(255, 141, 4, 141),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? true : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
      ),
    );
  }
}
